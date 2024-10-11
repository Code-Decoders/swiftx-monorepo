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

const createWallet = async () => {
  const response = await fetch(
    "https://swiftx-nextjs.vercel.app/api/wallet",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
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
      const response = await createWallet();
      const { data, error } = await supabaseClient.from("users").update({
        metadata: response,
      }).eq("id", payload.record.id);
      console.log(data, error);
      break;
    }
    case "transactions:INSERT": {
    }
    case "transactions:UPDATE": {
    }
  }
  return new Response("OK");
});
