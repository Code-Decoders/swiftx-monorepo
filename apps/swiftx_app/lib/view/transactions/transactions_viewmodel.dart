import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/transaction_model.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/core/service/transaction_service.dart';

class TransactionsViewModel extends BaseViewModel {
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  late UserModel _user;
  UserModel get user => _user;

  final authService = locator<AuthService>();

  final transactionService = locator<TransactionService>();
  TransactionsViewModel() {
    print("TransactionsViewModel created");
    getData();
  }

  void getData() async {
    setBusyAndNotify(true);
    await Future.wait([
      authService.getUserData(),
      transactionService.getTransactions(),
    ]).then((value) {
      _user = value[0] as UserModel;
      _transactions = value[1] as List<TransactionModel>;
      setBusyAndNotify(false);
    }).catchError((error) {
      print(error);
      setBusyAndNotify(false);
    });
  }
}
