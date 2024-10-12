// pages/index.js
"use client";
import { useEffect, useState } from "react";
import Table from "./components/Table";
import { burnToken, getStats, getTransactions, getUserData, logout } from "./_lib/supabase";
import { useRouter } from "next/navigation";

const SGD_TO_USD_RATE = 0.77;
const AED_TO_USD_RATE = 0.27;

export function toCurrency(value: any, country: any) {
  switch (country) {
    case "Singapore":
      return "SGD " +  (value / SGD_TO_USD_RATE).toFixed(2);
    case "UAE":
      return "AED " + (value / AED_TO_USD_RATE).toFixed(2);
    default:
      break;
  }
}

export default function Home() {
  const [tableData, setTableData] = useState<any[]>([]);

  const [stats, setStats] = useState<any>({});

  interface User {
    country: string;
    // Add other user properties if needed
  }

  const [user, setUser] = useState<User | null>(null);
  useEffect(() => {
    getUserData().then((data) => setUser(data));
  }, []);

  const router = useRouter();

  useEffect(() => {
    getStats().then((data) => {
      setStats(data);
    });
    getTransactions().then((data) => {
      setTableData(data);
    });
  }, []);

  const onBurn = async (id: string) => {
    burnToken(parseInt(id));
    const data = await getTransactions();
    const stats = await getStats();
    setStats(stats);
    setTableData(data);
  };

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col items-center">
      <nav className="w-full bg-white shadow-md mb-6">
        <div className="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
          <div className="text-xl font-semibold text-gray-700">SwiftX</div>
          <button
            className="bg-primary text-white px-4 py-2 rounded hover:bg-blue-600"
            onClick={() => {
              logout();
              router.push("/login");
            }}
          >
            Logout
          </button>
        </div>
      </nav>
      <div className="w-full px-4 max-w-7xl">
        <h1 className="text-3xl font-semibold text-gray-700 mb-6 text-left">
          Hi Admin,
        </h1>
        <div className="grid grid-cols-3 gap-4 mb-6">
          <div className="bg-white p-4 rounded shadow-md">
            <h2 className="text-xl font-semibold text-gray-700">
              Processing Tokens
            </h2>
            <p className="text-2xl text-gray-900">
              {toCurrency(stats.processing_amount, user?.country ?? "")}
            </p>
          </div>
          <div className="bg-white p-4 rounded shadow-md">
            <h2 className="text-xl font-semibold text-gray-700">
              Received Tokens
            </h2>
            <p className="text-2xl text-gray-900">
              {toCurrency(stats.completed_amount, user?.country ?? "")}
            </p>
          </div>
          <div className="bg-white p-4 rounded shadow-md">
            <h2 className="text-xl font-semibold text-gray-700">
              Burned Tokens
            </h2>
            <p className="text-2xl text-gray-900">
              {toCurrency(stats.burned_amount, user?.country ?? "")}
            </p>
          </div>
        </div>
        <p className="text-lg text-gray-700 mb-6 text-left">
          Here are the transactions that have been made.
        </p>
        <Table
          data={tableData}
          onBurnToken={(transaction: any) => {
            onBurn(transaction.id);
          }}
        />
      </div>
    </div>
  );
}
