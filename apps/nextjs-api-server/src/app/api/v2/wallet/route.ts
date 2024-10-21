import { NextRequest, NextResponse } from "next/server";
import { ethers } from "ethers";
import { SwiftXTokenAbi, SwiftXTokenAddress } from "@/app/_lib/abi";

export async function POST(req: NextRequest) {
  const { account, amount, txId } = await req.json();

  const provider = new ethers.JsonRpcProvider("https://sepolia.base.org	");

  const signer = new ethers.Wallet(
    "1768e0e88185b51d871546b4af4f67eb2a6ef2111a91cd8ab3636efb95c16fdd",
    provider,
  );

  const swiftXToken = new ethers.Contract(
    SwiftXTokenAddress,
    SwiftXTokenAbi,
    signer,
  );

  const tx = await swiftXToken.initTransfer(
    ethers.parseEther(amount),
    txId,
    account,
  );

  const txDetail = await tx.wait();

  try {
    return NextResponse.json(
      {
        tx: txDetail,
      },
      {
        status: 200,
      },
    );
  } catch (err) {
    console.error(err);
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
