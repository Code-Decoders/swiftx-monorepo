import { Coinbase, Wallet } from "@coinbase/coinbase-sdk";
import { promises as fs } from "fs";
import os from "os";

const checkKeyExists = async (filePath) => {
  try {
    await fs.access(filePath);
    return true;
  } catch (err) {
    return false;
  }
};

export const coinbase = Coinbase.configureFromJson({
  filePath: `${os.homedir}/Code/web/swiftx-monorepo/apps/nextjs-api-server/src/lib/cdp_api_key.json`,
  useServerSigner: true,
});

export const fetchWallet = async () => {
  const filePath = "./key.json";

  let w;
  const fileExists = await checkKeyExists(filePath);

  if (fileExists) {
    w = await Wallet.create({
      networkId: Coinbase.networks.BaseSepolia,
    });

    let data = w.export();

    w.saveSeed(filePath, true);
  } else {
    w = await Wallet.create({
      networkId: Coinbase.networks.BaseSepolia,
    });

    let data = w.export();

    w.saveSeed(filePath, true);
  }

  return w;
};

const create = async () => {
  const res = await fetchWallet();
  console.log(res);
};

create();
