import { NextRequest } from "next/server";
import { createBundlerClient } from "viem/account-abstraction";
import { SwiftXTokenAbi, SwiftXTokenAddress } from "@/app/_lib/abi";
import { http } from "viem";
import { baseSepolia } from "viem/chains";
import { getEOAAccount, client, RPC_URL } from "@/app/_lib/eoaClient";

export default async function POST(req: NextRequest) {
  const account = await getEOAAccount();
  const { amount, txId, agency } = await req.json();

  const bundlerClient = createBundlerClient({
    account,
    client,
    transport: http(RPC_URL),
    chain: baseSepolia,
  });

  const initCall = {
    abi: SwiftXTokenAbi,
    functionName: "initTransfer",
    to: SwiftXTokenAddress,
    args: [amount, txId, agency],
  };

  const calls = (account.userOperation = {
    estimateGas: async (userOperation) => {
      const estimate =
        await bundlerClient.estimateUserOperationGas(userOperation);
      estimate.preVerificationGas = estimate.preVerificationGas * 2n;
      return estimate;
    },
  });
}
