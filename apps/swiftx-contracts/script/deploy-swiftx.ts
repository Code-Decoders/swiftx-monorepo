import { ethers } from "ethers";
import * as fs from "fs";
import * as path from "path";
import * as dotenv from "dotenv";
import readlineSync from "readline-sync";

dotenv.config();

interface ChainConfig {
  description: string;
  chainId: number;
  rpc: string;
  tokenBridge: string;
  wormholeRelayer: string;
  wormhole: string;
}

interface DeployedContracts {
  [chainId: number]: {
    networkName: string;
    SwiftX?: string;
    SwiftXToken?: string;
    deployedAt: string;
  };
}

function loadConfig(): ChainConfig[] {
  const configPath = path.resolve(__dirname, "../deploy-config/config.json");
  if (!fs.existsSync(configPath)) {
    throw new Error(`Configuration file not found at ${configPath}`);
  }
  return JSON.parse(fs.readFileSync(configPath, "utf8")).chains;
}

function selectChain(
  chains: ChainConfig[],
  role: "source" | "target",
): ChainConfig {
  console.log(`\nSelect the ${role.toUpperCase()} chain:`);
  chains.forEach((chain, index) => {
    console.log(`${index + 1}: ${chain.description}`);
  });

  const chainIndex =
    readlineSync.questionInt(
      `\nEnter the number for the ${role.toUpperCase()} chain: `,
    ) - 1;

  if (chainIndex < 0 || chainIndex >= chains.length) {
    throw new Error("Invalid chain selection.");
  }

  return chains[chainIndex];
}

async function main() {
  const chains = loadConfig();

  // Let the user select the source and target chains
  const sourceChain = selectChain(chains, "source");
  const targetChain = selectChain(chains, "target");

  console.log(
    `\nSource Chain Selected: ${sourceChain.description} (Chain ID: ${sourceChain.chainId})`,
  );
  console.log(
    `Target Chain Selected: ${targetChain.description} (Chain ID: ${targetChain.chainId})\n`,
  );

  // Initialize providers and wallets
  const sourceProvider = new ethers.JsonRpcProvider(sourceChain.rpc);
  const targetProvider = new ethers.JsonRpcProvider(targetChain.rpc);

  const sourceWallet = new ethers.Wallet(
    process.env.PRIVATE_KEY!,
    sourceProvider,
  );
  const targetWallet = new ethers.Wallet(
    process.env.PRIVATE_KEY!,
    targetProvider,
  );

  // Load compiled contract artifacts
  const swiftXJsonPath = path.resolve(
    __dirname,
    "../out/SwiftX.sol/SwiftX.json",
  );
  const swiftXTokenJsonPath = path.resolve(
    __dirname,
    "../out/SwiftXToken.sol/SwiftXToken.json",
  );

  if (!fs.existsSync(swiftXJsonPath) || !fs.existsSync(swiftXTokenJsonPath)) {
    throw new Error(
      "Compiled contract JSON files not found. Please compile the contracts first.",
    );
  }

  const swiftXJson = JSON.parse(fs.readFileSync(swiftXJsonPath, "utf8"));
  const swiftXAbi = swiftXJson.abi;
  const swiftXBytecode = swiftXJson.bytecode;

  const swiftXTokenJson = JSON.parse(
    fs.readFileSync(swiftXTokenJsonPath, "utf8"),
  );
  const swiftXTokenAbi = swiftXTokenJson.abi;
  const swiftXTokenBytecode = swiftXTokenJson.bytecode;

  try {
    // Deploy SwiftX on the source chain
    console.log(`\nDeploying SwiftX on ${sourceChain.description}...`);
    const SwiftXFactory = new ethers.ContractFactory(
      swiftXAbi,
      swiftXBytecode,
      sourceWallet,
    );
    const swiftXContract = await SwiftXFactory.deploy(
      sourceChain.wormholeRelayer,
      sourceChain.tokenBridge,
      sourceChain.wormhole,
    );
    await swiftXContract.waitForDeployment();
    const swiftXAddress = swiftXContract.target;
    console.log(
      `SwiftX deployed on ${sourceChain.description} at: ${swiftXAddress}`,
    );

    // Deploy SwiftXToken on the target chain
    console.log(`\nDeploying SwiftXToken on ${targetChain.description}...`);
    const SwiftXTokenFactory = new ethers.ContractFactory(
      swiftXTokenAbi,
      swiftXTokenBytecode,
      targetWallet,
    );
    const swiftXTokenContract = await SwiftXTokenFactory.deploy(
      "SwiftX Token",
      "SWXT",
      1, // tokenId, adjust as needed
      targetChain.wormholeRelayer,
      targetChain.tokenBridge,
      targetChain.wormhole,
      swiftXAddress, // parentContract address
      sourceChain.chainId,
    );
    await swiftXTokenContract.waitForDeployment();
    const swiftXTokenAddress = swiftXTokenContract.target;
    console.log(
      `SwiftXToken deployed on ${targetChain.description} at: ${swiftXTokenAddress}`,
    );

    // Register SwiftXToken as a valid sender in SwiftX
    console.log(
      `\nRegistering SwiftXToken (${swiftXTokenAddress}) as a valid sender in SwiftX (${swiftXAddress})...`,
    );

    // Initialize SwiftX contract instance
    const SwiftXContract = new ethers.Contract(
      swiftXAddress,
      swiftXAbi,
      sourceWallet,
    );

    // Assuming SwiftX has a function setRegisteredSender(uint16 chainId, bytes32 senderAddress)
    // Adjust the function name and parameters as per your SwiftX contract
    const registerTx = await SwiftXContract.setRegisteredSender(
      targetChain.chainId, // Chain ID of the target chain
      ethers.zeroPadValue(swiftXTokenAddress, 32), // Address of the deployed SwiftXToken contract, zero-padded to 32 bytes
    );
    await registerTx.wait();
    console.log(`SwiftXToken registered as a valid sender on SwiftX`);

    // Load existing deployed contract addresses from contracts.json
    const deployedContractsPath = path.resolve(
      __dirname,
      "../deploy-config/contracts.json",
    );
    let deployedContracts: DeployedContracts = {};

    if (fs.existsSync(deployedContractsPath)) {
      deployedContracts = JSON.parse(
        fs.readFileSync(deployedContractsPath, "utf8"),
      );
    }

    // Update the contracts.json file:
    // Add SwiftX to the source chain
    if (!deployedContracts[sourceChain.chainId]) {
      deployedContracts[sourceChain.chainId] = {
        networkName: sourceChain.description,
        deployedAt: new Date().toISOString(),
      };
    }
    deployedContracts[sourceChain.chainId].SwiftX = swiftXAddress;
    deployedContracts[sourceChain.chainId].deployedAt =
      new Date().toISOString();

    // Add SwiftXToken to the target chain
    if (!deployedContracts[targetChain.chainId]) {
      deployedContracts[targetChain.chainId] = {
        networkName: targetChain.description,
        deployedAt: new Date().toISOString(),
      };
    }
    deployedContracts[targetChain.chainId].SwiftXToken = swiftXTokenAddress;
    deployedContracts[targetChain.chainId].deployedAt =
      new Date().toISOString();

    // Save the updated contracts.json file
    fs.writeFileSync(
      deployedContractsPath,
      JSON.stringify(deployedContracts, null, 2),
    );
    console.log(
      `\nDeployed contract addresses have been saved to contracts.json`,
    );
  } catch (error: any) {
    if (error.code === "INSUFFICIENT_FUNDS") {
      console.error(
        "Error: Insufficient funds for deployment. Please make sure your wallet has enough funds to cover the gas fees.",
      );
    } else {
      console.error("An unexpected error occurred:", error.message);
    }
    process.exit(1);
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
