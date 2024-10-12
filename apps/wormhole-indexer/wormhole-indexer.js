const { createClient } = require("@supabase/supabase-js");
const fetchWormholeTx = require("./fetch-wormhole-tx");

const SUPABASE_URL = "https://ewxiidixnidmpnkgivwu.supabase.co";
const SUPABASE_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV3eGlpZGl4bmlkbXBua2dpdnd1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0NzgwMDksImV4cCI6MjA0NDA1NDAwOX0.6vuqfeAT2yKdgGZo5n8lIY5d8dfdnwZEQYSIR3MldpY";

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const indexWormhole = async () => {
  try {
    const { data: transactions, error: fetchError } = await supabase
      .from("transactions")
      .select("id, transaction_hash, status")
      .eq("status", "pending");

    if (fetchError) {
      throw new Error(`Error fetching transactions: ${fetchError.message}`);
    }

    console.log(`Fetched ${transactions.length} pending transactions.`);

    for (const tx of transactions) {
      console.log(`Indexing transaction: ${tx.transaction_hash}`);

      const wormholeTx = await fetchWormholeTx(tx.transaction_hash);

      if (wormholeTx.operations.length === 0) {
        console.log(
          `No operations found for transaction: ${tx.transaction_hash}`
        );
        continue;
      }

      if (wormholeTx.operations[0].targetChain.status === "completed") {
        console.log(`Transaction ${tx.transaction_hash} confirmed on Wormhole`);

        const { error: updateError } = await supabase
          .from("transactions")
          .update({ status: "completed" })
          .eq("id", tx.id);

        if (updateError) {
          throw new Error(
            `Error updating transaction status: ${updateError.message}`
          );
        }

        console.log(
          `Transaction ${tx.transaction_hash} status updated to confirmed.`
        );
      } else {
        console.log(
          `Transaction ${tx.transaction_hash} not yet confirmed on Wormhole.`
        );
      }
    }
  } catch (error) {
    console.error(`Error during wormhole indexing process: ${error.message}`);
  }
};
const startIndexingProcess = async () => {
  await indexWormhole();
  let secondsLeft = 60;
  const countdownInterval = setInterval(async () => {
    process.stdout.write(
      `\rRefetching pending transactions in ${secondsLeft} seconds...`
    );
    secondsLeft -= 1;
    if (secondsLeft < 0) {
      clearInterval(countdownInterval);
      console.clear();
      await startIndexingProcess();
    }
  }, 1000);
};

startIndexingProcess();
