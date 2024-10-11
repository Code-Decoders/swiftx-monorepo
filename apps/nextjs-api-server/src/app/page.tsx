// pages/index.js
"use client";
import { useEffect, useState } from "react";
import Table from "./components/Table";
import { burnToken, getTransactions, logout } from "./_lib/supabase";
import { useRouter } from "next/navigation";

export default function Home() {
  const [tableData, setTableData] = useState<any[]>([]);

  const router = useRouter();

  useEffect(() => {
    getTransactions().then((data) => {
      setTableData(data);
    });
  }, []);

  const onBurn = async (id: string) => {
    burnToken(parseInt(id));
    const data = await getTransactions();
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
      <div className="w-full max-w-7xl">
        <h1 className="text-3xl font-semibold text-gray-700 mb-6 text-left">
          Hi Admin,
        </h1>
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
