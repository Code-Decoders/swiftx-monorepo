import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/model/transaction_model.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/core/supabase.dart';

class TransactionService {
  Future<void> createTransaction(UserModel recipient, double amount) async {
    try {
      final user = await locator<AuthService>().getUserData();
      final transaction = TransactionModel(
        id: 0,
        created_at: DateTime.now(),
        sender: user,
        receiver: recipient,
        amount: amount,
        status: "completed",
        sender_id: user.id,
        receiver_id: recipient.id,
      );
      await supabase.from("transactions").insert(transaction.toMap());
      await supabase.from("users").update({
        "balance": user.balance - amount,
      }).eq("id", user.id);
      await supabase.from("users").update({
        "balance": recipient.balance + amount,
      }).eq("id", recipient.id);
    } catch (e) {
      throw e;
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      final user = await locator<AuthService>().getUserData();
      final response = await supabase
          .from("transactions")
          .select("*, sender:sender_id(*), receiver:receiver_id(*)")
          .or("sender_id.eq.${user.id},receiver_id.eq.${user.id}")
          .order("created_at", ascending: false);
      return response.map((e) => TransactionModel.fromMap(e)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<TransactionModel>> getRecentTransactions() async {
    try {
      final user = await locator<AuthService>().getUserData();
      final response = await supabase
          .from("transactions")
          .select("*, sender:sender_id(*), receiver:receiver_id(*)")
          .or("sender_id.eq.${user.id},receiver_id.eq.${user.id}")
          .order("created_at", ascending: false)
          .limit(5);
      return response.map((e) => TransactionModel.fromMap(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}
