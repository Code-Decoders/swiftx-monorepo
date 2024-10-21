//config.js
import { createPublicClient, http } from "viem";
import { toCoinbaseSmartAccount } from "viem/account-abstraction";
import { baseSepolia } from "viem/chains";
import { privateKeyToAccount } from "viem/accounts";

// Your RPC url. Make sure you're using the right network (base vs base-sepolia)
export const RPC_URL = "https://base-sepolia-rpc.publicnode.com";

export const client = createPublicClient({
  chain: baseSepolia,
  transport: http(RPC_URL),
});

export const getEOAAccount = async () => {
  const owner = privateKeyToAccount(
    "0x6acdfe90bb2a61ac51529637928a76c1a734641d0fe691a8546ef33323b6d23c",
  );
  const account = await toCoinbaseSmartAccount({
    client,
    owners: [owner],
  });

  return account;
};
