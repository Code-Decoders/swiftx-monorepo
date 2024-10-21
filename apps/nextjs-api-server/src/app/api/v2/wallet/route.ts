import { NextRequest, NextResponse } from "next/server";
import { fetchWallet } from "@/lib/initCoinbaseWallet";
import { SwiftXTokenAbi, SwiftXTokenAddress } from "@/app/_lib/abi";

export async function POST(req: NextRequest) {
  const { account, amount, txId } = await req.json();
  const wallet = await fetchWallet();

  const confirmTransferArgs = {
    amount,
    txId,
    account,
  };

  try {
    const contractInvocation = await wallet.invokeContract({
      contractAddress: SwiftXTokenAddress,
      abi: SwiftXTokenAbi,
      method: "confirmTransfer",
      args: confirmTransferArgs,
    });

    const invocation = await contractInvocation.wait();
    return NextResponse.json(
      {
        invocation: invocation.getRawTransaction(),
      },
      {
        status: 200,
      },
    );
  } catch (err) {
    return NextResponse.json(
      {
        error: err,
      },
      {
        status: 503,
      },
    );
  }
}
