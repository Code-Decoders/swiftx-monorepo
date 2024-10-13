require("dotenv").config();
const axios = require("axios");
const { ethers } = require("ethers");

const OWLRACLE_API_KEY = process.env.OWLRACLE_API_KEY;
const CONFIG = {
  POLYGON: {
    RPC: "https://polygon-rpc.com/",
    GAS_API: `https://api.owlracle.info/v4/poly/gas?apikey=${OWLRACLE_API_KEY}`,
  },
  ARBITRUM: {
    RPC: "https://rpc.ankr.com/arbitrum",
    GAS_API: `https://api.owlracle.info/v4/arb/gas?apikey=${OWLRACLE_API_KEY}`,
  },
  AVALANCHE: {
    RPC: "https://avalanche-mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
    GAS_API: `https://api.owlracle.info/v4/avax/gas?apikey=${OWLRACLE_API_KEY}`,
  },
};

const getGasPrice = async (CHAIN) => {
  try {
    const response = await axios.get(CONFIG[CHAIN].GAS_API);

    if (response.status === 200) {
      return response.data.speeds;
    } else {
      console.error("Failed to fetch gas prices:", response.data.message);
    }
  } catch (error) {
    console.error("Error fetching gas price:", error.message);
  }
};

// Function to check network congestion using pending transactions
const getNetworkCongestion = async (CHAIN) => {
  try {
    // Connecting to Ethereum using a provider (using Infura here)
    const provider = new ethers.JsonRpcProvider(CONFIG[CHAIN].RPC);

    const pendingTxCount = await provider.getBlock("pending", true);
    return pendingTxCount.transactions.length;
  } catch (error) {
    console.error("Error fetching pending transactions:", error.message);
  }
};

const monitorNetworks = async () => {
  const table = [];
  for (const chain in CONFIG) {
    const [slow, standard, fast, instant] = await getGasPrice(chain);
    const congestion = await getNetworkCongestion(chain);
    table.push({
      Netowrk: chain,
      Congestion: congestion,
      "🐢 Slow": parseFloat(slow.estimatedFee.toFixed(4)),
      "🚗 Standard": parseFloat(standard.estimatedFee.toFixed(4)),
      "🚀 Fast": parseFloat(fast.estimatedFee.toFixed(4)),
      "🛸 Instant": parseFloat(instant.estimatedFee.toFixed(4)),
    });
  }
  console.clear();
  console.table(table);
};

const startMonitoring = async () => {
  await monitorNetworks();
  let secondsLeft = 30;
  const countdownInterval = setInterval(async () => {
    process.stdout.write(
      `\rRefetching pending transactions in ${secondsLeft} seconds...`
    );
    secondsLeft -= 1;
    if (secondsLeft < 0) {
      clearInterval(countdownInterval);
      console.clear();
      console.log("Refetching pending transactions...");
      await startMonitoring();
    }
  }, 1000);
};

startMonitoring();
