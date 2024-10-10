import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";

export async function GET(req: NextRequest) {
  const searchParams = req.nextUrl.searchParams;

  const txId = searchParams.get("txId") ?? "";

  console.log(txId);

  try {
    const { data } = await dwClient.getTransaction({
      id: txId,
    });

    return NextResponse.json(data, { status: 200 });
  } catch (err) {
    console.error(err);
    return NextResponse.json(err, { status: 503 });
  }
}

export async function POST(req: NextRequest) {
  const { walletId, desAddress, amount, tokenId } = await req.json();

  try {
    const { data } = await dwClient.createTransaction({
      amount,
      walletId,
      tokenId,
      destinationAddress: desAddress,
      fee: {
        type: "level",
        config: {
          feeLevel: "MEDIUM",
        },
      },
    });

    return NextResponse.json(data, {
      status: 200,
    });
  } catch (err) {
    console.error(err);
    return NextResponse.json(err, {
      status: 500,
    });
  }
}
