export const SwiftXTokenAbi = [
  {
    type: "function",
    name: "confirmTransfer",
    inputs: [
      { name: "amount", type: "uint256", internalType: "uint256" },
      { name: "txId", type: "uint256", internalType: "uint256" },
      { name: "sender", type: "address", internalType: "address" },
    ],
    outputs: [],
    stateMutability: "payable",
  },
] as const;

export const SwiftXTokenAddress = "0xd1c6b50a1b2e37a9d152d9330947d3858e5d016b";
