import { NextRequest, NextResponse } from "next/server";
import { dwClient } from "@/lib/initDevWallet";

export async function POST(req: NextRequest, { params }: { params: { method: string } }) {
    const { method } = params
    const { paramSign, contractAddress, walletId } = await req.json()
    
    try {
        const { data } = await dwClient.createContractExecutionTransaction({
            contractAddress: contractAddress,
            walletId: walletId,
            abiFunctionSignature: method,
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