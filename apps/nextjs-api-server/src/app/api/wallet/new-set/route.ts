import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";

export async function GET(req: NextRequest) {
  const searchParams = req.nextUrl.searchParams;

  const name = searchParams.get("name") ?? "";

  console.log(name);

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
