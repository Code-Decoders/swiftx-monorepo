import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/request_model.dart';
import 'package:swiftx_app/core/service/request_service.dart';
import 'package:swiftx_app/core/service/transaction_service.dart';

class RequestDetailViewModel extends BaseViewModel {
  final transactionService = locator<TransactionService>();
  final requestService = locator<RequestService>();

  Future<void> onPayRequest(RequestModel request) async {
    try {
      await requestService.approvedRequest(request);
    } catch (e) {
      throw e;
    }
  }

  Future<void> onCancelRequest(RequestModel request) async {
    try {
      await requestService.deleteRequest(request.id);
    } catch (e) {
      throw e;
    }
  }
}
