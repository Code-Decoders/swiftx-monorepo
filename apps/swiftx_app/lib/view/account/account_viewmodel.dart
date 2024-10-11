import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class AccountViewModel extends BaseViewModel {
  final authService = locator<AuthService>();

  final router = locator<AppRouter>();

  late UserModel _user;
  UserModel get user => _user;

  AccountViewModel() {
    getData();
  }

  Future getData() async {
    setBusyAndNotify(true);
    Future.wait([
      authService.getUserData(),
    ]).then((value) {
      _user = value[0];
      setBusyAndNotify(false);
    }).catchError((error) {
      setBusyAndNotify(false);
    });
  }

  void logout() {
    authService.signOut().then((value) {
      router.replace(const WelcomeRoute());
    });
  }

  void navigateToTransactions() {
    router.push(TransactionTab());
  }
}
