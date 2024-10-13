import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";
import { v4 } from "uuid";
import { Balance } from "@circle-fin/developer-controlled-wallets";
import { Wallet } from "@circle-fin/developer-controlled-wallets/dist/types/clients/developer-controlled-wallets";

const drip = async (walletAddress: string) => {
  console.log("Dripping", walletAddress);
  const res = await fetch("https://api.circle.com/v1/faucet/drips", {
    method: "POST",
    headers: {
      Authorization:
        "Bearer TEST_API_KEY:251ea38c58825f4a9b033c0e8714facc:27d080718d5a8b287d067d25a655d19d",
      "Content-Type": "application/json",
    },
    body: JSON
      .stringify(
        {
          address: walletAddress,
          blockchain: "ARB-SEPOLIA",
          native: true,
        },
      ),
  });

  console.log(res.status);
};

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

export async function POST(req: NextRequest) {
  const { name } = await req.json();
  try {
    const { data: walData } = await dwClient.createWalletSet({
      name,
    });

    if (walData?.walletSet) {
      const { data } = await dwClient.createWallets({
        blockchains: ["ARB-SEPOLIA", "ETH-SEPOLIA"],
        count: 1,
        metadata: [{
          name,
        }],
        walletSetId: walData?.walletSet.id ?? "",
        accountType: "SCA",
        idempotencyKey: v4(),
      });

      if (data?.wallets) {
        await drip(data.wallets[0].address);
      }

      return NextResponse.json(data, { status: 200 });
    }

    return NextResponse.json("Unknown error", { status: 500 });
  } catch (err) {
    console.error(err);
    return NextResponse.json(err, { status: 503 });
  }
}
