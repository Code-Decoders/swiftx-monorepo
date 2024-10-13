import { createClient } from "jsr:@supabase/supabase-js@2";

interface WebhookPayload {
  type: "INSERT" | "UPDATE" | "DELETE";
  table: string;
  record: any;
  schema: "public";
  old_record: null | any;
}

const supabaseClient = createClient(
  Deno.env.get("SUPABASE_URL") ?? "",
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
);

const OPTIMISED_CONTRACT_ADDRESS = "0xA88E420bBA06379bd7872939fF510e2E3EA62F4a";
const OPTIMISED_CHAIN = "ARB-SEPOLIA";

const swiftXAPICall = async (
  method: "initTransfer" | "confirmTransfer",
  body: any,
) => {
  const response = await fetch(
    "https://swiftx-nextjs.vercel.app/api/wallet/tx/" + method,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    },
  );
  return response.json();
};

const createWallet = async (email: string) => {
  const response = await fetch(
    "https://swiftx-nextjs.vercel.app/api/wallet",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ name: email }),
    },
  );
  return await response.json();
};

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json();

  const operation = `${payload.table}:${payload.type}`;
  console.log(operation);
  switch (operation) {
    case "users:INSERT": {
      const response = await createWallet(payload.record.email);
      const { data, error } = await supabaseClient.from("users").update({
        metadata: response,
      }).eq("id", payload.record.id);
      console.log(data, error);
      break;
    }
    case "transactions:INSERT": {
      const amount = eToNumber(payload.record.amount * 10 ** 18);
      const receiverId = payload.record.receiver_id;
      const senderId = payload.record.sender_id;

      console.log("receiverId", receiverId);
      console.log("senderId", senderId);
      console.log("amount", amount);

      const { data: receiver } = await supabaseClient.from("users").select(
        "metadata",
      ).eq(
        "id",
        receiverId,
      ).single();

      console.log("receiver", receiver);

      const { data: sender } = await supabaseClient.from("users").select(
        "metadata",
      ).eq(
        "id",
        senderId,
      ).single();

      console.log("sender", sender);

      const response = await swiftXAPICall("initTransfer", {
        paramSign: [
          amount,
          payload.record.id,
          receiver!.metadata.wallets[0].address,
        ],
        contractAddress: OPTIMISED_CONTRACT_ADDRESS,
        walletId: sender!.metadata.wallets.find(
          (w: any) => w.blockchain === OPTIMISED_CHAIN,
        ).id,
      });

      console.log(response);

      const { data, error } = await supabaseClient.from("transactions").update({
        transaction_hash: response.txHash,
      }).eq("id", payload.record.id);

      console.log(data, error);
      break;
    }
    case "transactions:UPDATE": {
      console.log(payload.old_record.status, payload.record.status);
      if (
        payload.old_record.status === "completed" &&
        payload.record.status === "burned"
      ) {
        const amount = eToNumber(payload.record.amount * 10 ** 18);
        const receiverId = payload.record.receiver_id;
        const senderId = payload.record.sender_id;

        console.log("receiverId", receiverId);
        console.log("senderId", senderId);
        console.log("amount", amount);

        const { data: receiver } = await supabaseClient.from("users").select(
          "metadata",
        ).eq(
          "id",
          receiverId,
        ).single();

        console.log("receiver", receiver);

        const { data: sender } = await supabaseClient.from("users").select(
          "metadata",
        ).eq(
          "id",
          senderId,
        ).single();

        console.log("sender", sender);

        const response = await swiftXAPICall("confirmTransfer", {
          paramSign: [
            amount,
            payload.record.id,
            sender!.metadata.wallets[0].address,
          ],
          contractAddress: OPTIMISED_CONTRACT_ADDRESS,
          walletId: receiver!.metadata.wallets.find(
            (w: any) => w.blockchain === OPTIMISED_CHAIN,
          ).id,
        });

        console.log(response);

        const { data, error } = await supabaseClient.from("transactions")
          .update({
            transaction_hash: response.txHash,
          }).eq("id", payload.record.id);

        console.log(data, error);
        break;
      }
    }
  }
  return new Response("OK");
});

function eToNumber(num: any) {
  let sign = "";
  (num += "").charAt(0) == "-" && (num = num.substring(1), sign = "-");
  let arr = num.split(/[e]/ig);
  if (arr.length < 2) return sign + num;
  let dot = (.1).toLocaleString().substr(1, 1),
    n = arr[0],
    exp = +arr[1],
    w = (n = n.replace(/^0+/, "")).replace(dot, ""),
    pos = n.split(dot)[1] ? n.indexOf(dot) + exp : w.length + exp,
    L: any = pos - w.length,
    s = "" + BigInt(w);
  w = exp >= 0
    ? (L >= 0 ? s + "0".repeat(L) : r())
    : (pos <= 0 ? "0" + dot + "0".repeat(Math.abs(pos)) + s : r());
  L = w.split(dot);
  if (L[0] == 0 && L[1] == 0 || (+w == 0 && +s == 0)) w = 0; //** added 9/10/2021
  return sign + w;
  function r() {
    return w.replace(new RegExp(`^(.{${pos}})(.)`), `$1${dot}$2`);
  }
}
