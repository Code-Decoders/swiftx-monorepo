"use client"
import { useEffect, useState } from "react";
import { getUserData } from "../_lib/supabase";

const SGD_TO_USD_RATE = 0.77;
const AED_TO_USD_RATE = 0.27;

export function toCurrency(value, country) {
    switch (country) {
        case "Singapore":
            return (value / SGD_TO_USD_RATE).toFixed(2);
        case "UAE":
            return (value / AED_TO_USD_RATE).toFixed(2);
        default:
            break;
    }
}

export default function Table({ data, onBurnToken }) {
    const [user, setUser] = useState(null);
    useEffect(() => {
        getUserData().then((data) => setUser(data));
    }, [])

    return (
        <div className="overflow-x-auto">
            <table className="min-w-full bg-white border border-gray-300">
                <thead>
                    <tr className="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                        <th className="py-3 px-6 text-left">Name</th>
                        <th className="py-3 px-6 text-left">Email</th>
                        <th className="py-3 px-6 text-left">Amount</th>
                        <th className="py-3 px-6 text-left">Transacted At</th>
                        <th className="py-3 px-6 text-center">Action</th>
                    </tr>
                </thead>
                <tbody className="text-gray-700 text-sm font-light">
                    {data.map((item, index) => (
                        <tr key={index} className="border-b border-gray-200 hover:bg-gray-100">
                            <td className="py-3 px-6 text-left whitespace-nowrap">{item.receiver.name}</td>
                            <td className="py-3 px-6 text-left">{item.receiver.email}</td>
                            <td className="py-3 px-6 text-left">{user.country === "UAE" ? "AED" : "SGD"} {toCurrency(item.amount, user.country)}</td>
                            <td className="py-3 px-6 text-left">{new Date(item.created_at).toLocaleDateString('en-US', {
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit',
                            })}</td>
                            <td className="py-3 px-6 text-center">
                                <button
                                    className="bg-primary text-white py-1 px-3 rounded-full text-xs hover:bg-blue-700"
                                    onClick={() => onBurnToken(item)}
                                >
                                    Burn Token
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
