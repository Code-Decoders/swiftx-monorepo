import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class AccountViewModel extends BaseViewModel {
  final authService = locator<AuthService>();

  final router = locator<AppRouter>();

  void logout() {
    authService.signOut().then((value) {
      router.replace(WelcomeRoute());
    });
  }
}
