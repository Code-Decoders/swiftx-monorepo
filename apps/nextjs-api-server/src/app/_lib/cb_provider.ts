import CoinbaseWalletSDK from "@coinbase/wallet-sdk";

const sdk = new CoinbaseWalletSDK({
  appName: "SwiftX",
  appLogoUrl: "https://example.com/logo.png",
  appChainIds: [84532],
});

export const provider = sdk.makeWeb3Provider();
