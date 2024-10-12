const fetchWormholeTx = async (txid) => {
  try {
    const response = await fetch(
      `https://api.testnet.wormholescan.io/api/v1/operations?txHash=${txid}`
    );

    if (!response.ok) {
      throw new Error(`Network response was not ok: ${response.statusText}`);
    }

    const data = await response.json();

    if (!data || typeof data !== "object") {
      throw new Error("Invalid data format received");
    }

    return data;
  } catch (error) {
    console.error("Error fetching Wormhole transaction:", error);
    throw error;
  }
};

module.exports = fetchWormholeTx;
