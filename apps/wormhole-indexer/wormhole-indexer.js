const { createClient } = require("@supabase/supabase-js");
const fetchWormholeTx = require("./fetch-wormhole-tx");

const SUPABASE_URL = "https://ewxiidixnidmpnkgivwu.supabase.co";
const SUPABASE_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV3eGlpZGl4bmlkbXBua2dpdnd1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0NzgwMDksImV4cCI6MjA0NDA1NDAwOX0.6vuqfeAT2yKdgGZo5n8lIY5d8dfdnwZEQYSIR3MldpY";

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const indexWormhole = async () => {
  const log = [];

  try {
    const { data: transactions, error: fetchError } = await supabase
      .from("transactions")
      .select("id, transaction_hash, status")
      .eq("status", "processing");

    if (fetchError) {
      throw new Error(`Error fetching transactions: ${fetchError.message}`);
    }

    console.log(`Fetched ${transactions.length} pending transactions.`);

    for (const tx of transactions) {
      const item = {};

      item.transaction_hash = tx.transaction_hash;

      const wormholeTx = await fetchWormholeTx(tx.transaction_hash);

      if (wormholeTx.operations.length === 0) {
        item.status = "no operations";
        item[" "] = "🔄";
        log.push(item);
        continue;
      }

      if (wormholeTx.operations[0].targetChain.status === "completed") {
        item.status = "completed";

        const { error: updateError } = await supabase
          .from("transactions")
          .update({ status: "completed" })
          .eq("id", tx.id);

        if (updateError) {
          throw new Error(
            `Error updating transaction status: ${updateError.message}`
          );
        }
        item[" "] = "✅";
      } else {
        item.status = "processing";
        item[" "] = "🔄";
      }
      log.push(item);
    }
  } catch (error) {
    console.error(`Error during wormhole indexing process: ${error.message}`);
  }

  if (log.length !== 0) {
    console.table(log);
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
