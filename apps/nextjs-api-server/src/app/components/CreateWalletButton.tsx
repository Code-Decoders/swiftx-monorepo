"use client";
import React, { useCallback } from "react";
import { CoinbaseWalletSDK } from "@coinbase/wallet-sdk";
import { CoinbaseWalletLogo } from "./CoinbaseWalletLogo";

const buttonStyles = {
  background: "transparent",
  border: "1px solid transparent",
  boxSizing: "border-box",
  display: "flex",
  alignItems: "center",
  justifyContent: "space-between",
  width: 200,
  fontFamily: "Arial, sans-serif",
  fontWeight: "bold",
  fontSize: 18,
  backgroundColor: "#0052FF",
  paddingLeft: 15,
  paddingRight: 30,
  borderRadius: 10,
};

const sdk = new CoinbaseWalletSDK({
  appName: "SwiftX",
  appLogoUrl: "https://example.com/logo.png",
  appChainIds: [84532],
});

const provider = sdk.makeWeb3Provider();

export function BlueCreateWalletButton({
  handleSuccess,
  handleError,
}: {
  handleSuccess: (val: any) => void;
  handleError: (val: any) => void;
}) {
  const createWallet = useCallback(async () => {
    try {
      const [address] = (await provider.request({
        method: "eth_requestAccounts",
      })) as any;
      handleSuccess(address);
    } catch (error) {
      handleError(error);
    }
  }, [handleSuccess, handleError]);

  return (
    <button style={buttonStyles as any} onClick={createWallet}>
      <CoinbaseWalletLogo />
      Create Wallet
    </button>
  );
}
