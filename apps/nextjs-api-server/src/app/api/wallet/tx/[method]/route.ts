import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";

export async function POST(req: NextRequest, { params }: { params: { method: string } }) {
    const { method } = params
    // JSON.stringify(
    //     {
    //         "paramSign": ["something", 12, 3],
    //         "contractAddress": "29292",
    //         "walletId": "asldkf"
    //     }
    // )
    const { paramSign, contractAddress, walletId } = await req.json()
    let functionSign;

    switch (method) {
        case "initTransfer":
            functionSign = "initTransfer(uint256,uint256,address)"
            break;
        case "confirmTransfer":
            functionSign = "confirmTransfer(uint256,uint256,address)"
            break;
    }
    
    try {
        const { data } = await dwClient.createContractExecutionTransaction({
            contractAddress: contractAddress,
            walletId: walletId,
            abiFunctionSignature: functionSign,
            abiParameters: paramSign,
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
        console.error(err)
        return NextResponse.json({
            err
        }, {
            status: 500
        })
    }
}