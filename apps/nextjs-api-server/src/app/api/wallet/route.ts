import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";
import { v4 } from "uuid";
import { Balance } from "@circle-fin/developer-controlled-wallets";
import { Wallet } from "@circle-fin/developer-controlled-wallets/dist/types/clients/developer-controlled-wallets";

export async function GET(req: NextRequest) {
  try {
    const searchParams = req.nextUrl.searchParams;
    const id = searchParams.get("id") ?? "";
    let balances: Balance[] | undefined = [],
      wallet: Wallet | undefined = undefined;

    const res1 = await dwClient.getWalletTokenBalance({
      id: id,
    });

    const res2 = await dwClient.getWallet({
      id: id,
    });

    balances = res1.data?.tokenBalances;
    wallet = res2.data?.wallet;

    return NextResponse.json(
      {
        balances,
        wallet,
      },
      {
        status: 200,
      },
    );
  } catch (e) {
    console.error(e);
    return NextResponse.json(e, { status: 500 });
  }
}

export async function POST(_: NextRequest) {
  try {
    console.log("Creating wallet set");

    const { data } = await dwClient.createWallets({
      blockchains: ["ARB-SEPOLIA", "ETH-SEPOLIA"],
      count: 1,
      walletSetId: "3a3d1565-28dd-5cf2-b7c0-5c1b865c5142",
      accountType: "SCA",
      idempotencyKey: v4(),
    });

    return NextResponse.json(data, { status: 200 });
  } catch (err) {
    console.error(err);
    return NextResponse.json(err, { status: 503 });
  }
}
