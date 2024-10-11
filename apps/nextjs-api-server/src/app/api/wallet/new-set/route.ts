import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";

export async function POST(req: NextRequest) {
  const name = await req.json();

  try {
    console.log("Creating wallet set");

    const { data } = await dwClient.createWalletSet({
      name,
    });

    return NextResponse.json(data, { status: 200 });
  } catch (err) {
    console.error(err);
    return NextResponse.json(err, { status: 503 });
  }
}
