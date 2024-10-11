import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/request_model.dart';
import 'package:swiftx_app/core/service/request_service.dart';
import 'package:swiftx_app/core/service/transaction_service.dart';

class RequestDetailViewModel extends BaseViewModel {
  final transactionService = locator<TransactionService>();
  final requestService = locator<RequestService>();
  final router = locator<AppRouter>();

  Future<void> onPayRequest(RequestModel request) async {
    try {
      await requestService.approvedRequest(request);
      router.maybePopTop();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onCancelRequest(RequestModel request) async {
    try {
      await requestService.deleteRequest(request.id);
      router.maybePopTop();
    } catch (e) {
      rethrow;
    }
  }
}
