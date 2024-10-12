import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";
import { TokenTransfer } from "@wormhole-foundation/sdk";

export async function POST(
  req: NextRequest,
  { params }: { params: { method: string } },
) {
  const { method } = params;
  // JSON.stringify(
  //     {
  //         "paramSign": ["something", 12, 3],
  //         "contractAddress": "29292",
  //         "walletId": "asldkf"
  //     }
  // )
  const { paramSign, contractAddress, walletId } = await req.json();
  let functionSign;

  switch (method) {
    case "initTransfer":
      functionSign = "initTransfer(uint256,uint256,address)";
      break;
    case "confirmTransfer":
      functionSign = "confirmTransfer(uint256,uint256,address)";
      break;
  }

  const qoute = await Relayer()
  try {
    const { data } = await dwClient.createContractExecutionTransaction({
      contractAddress: contractAddress,
      walletId: walletId,
      abiFunctionSignature: functionSign,
      abiParameters: paramSign,
      amount: "0.001",
      fee: {
        type: "level",
        config: {
          feeLevel: "MEDIUM",
        },
      },
    });

    console.log(data);

    let txData;
    let attempts = 0;
    const maxAttempts = 5;
    const delay = 3000;

    while (attempts < maxAttempts) {
      await new Promise((resolve) => setTimeout(resolve, delay));
      const response = await dwClient.getTransaction({
        id: data!.id,
      });
      txData = response.data;

      if (txData!.transaction?.txHash) {
        break;
      }
      console.log("Attempt", attempts);

      attempts++;
    }

    console.log(txData);

    const txHash = txData!.transaction?.txHash;

    console.log(txHash);

    return NextResponse.json({ ...data, txHash }, {
      status: 200,
    });
  } catch (err) {
    console.error(err);
    return NextResponse.json({
      err,
    }, {
      status: 500,
    });
  }
}
