import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/model/request_model.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/core/service/transaction_service.dart';
import 'package:swiftx_app/core/supabase.dart';

class RequestService {
  Future<void> createRequest(UserModel approver, double amount) async {
    try {
      final user = await locator<AuthService>().getUserData();
      final request = RequestModel(
        id: 0,
        created_at: DateTime.now(),
        requester: user,
        approver: approver,
        amount: amount,
        requester_id: user.id,
        approver_id: approver.id,
      );
      await supabase.from("requests").insert(request.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RequestModel>> getRequests() async {
    try {
      final user = await locator<AuthService>().getUserData();
      final response = await supabase
          .from("requests")
          .select("*, requester:requester_id(*), approver:approver_id(*)")
          .or("requester_id.eq.${user.id},approver_id.eq.${user.id}")
          .order("created_at", ascending: false);
      return response.map((e) => RequestModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> approvedRequest(RequestModel request) async {
    try {
      await locator<TransactionService>()
          .createTransaction(request.requester, request.amount);
      await deleteRequest(request.id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRequest(int id) async {
    try {
      await supabase.from("requests").delete().eq("id", id);
    } catch (e) {
      rethrow;
    }
  }
}
