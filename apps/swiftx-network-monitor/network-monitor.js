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
      const [slow, standard, fast, instant] = response.data.speeds;
      console.log(
        `Gas Prices:\n
🛴 Slow - ${slow.estimatedFee} GWEI
🚗 Standard - ${standard.estimatedFee} GWEI
🚀 Fast - ${fast.estimatedFee} GWEI
🛸 Instant - ${instant.estimatedFee} GWEI`
      );
      return response.data;
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
    console.log(`Pending Transactions: ${pendingTxCount.transactions.length}`);
    return pendingTxCount.transactions.length;
  } catch (error) {
    console.error("Error fetching pending transactions:", error.message);
  }
};

const monitorNetworks = async () => {
  for (const chain in CONFIG) {
    console.log(`\nChecking ${chain} Network...`);
    await getGasPrice(chain);
    await getNetworkCongestion(chain);
    console.log("=====================================");
  }
};

console.log("Network Monitor Started...");
monitorNetworks();
setInterval(() => {
  monitorNetworks();
}, 60000); // Polling every 60 seconds
