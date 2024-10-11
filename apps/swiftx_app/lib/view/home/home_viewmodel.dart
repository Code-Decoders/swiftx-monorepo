import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/transaction_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/core/service/transaction_service.dart';

class HomeViewModel extends BaseViewModel {

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  final authService = locator<AuthService>();
  final transactionService = locator<TransactionService>();

  HomeViewModel() {
    getData();
  }

  Future getData() async {
    setBusyAndNotify(true);
    Future.wait([
      transactionService.getRecentTransactions()
    ]).then((value) {
      _transactions = value[0];
      setBusyAndNotify(false);
    }).catchError((error) {
      setBusyAndNotify(false);
    });
  }
}
