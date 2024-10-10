import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class KycViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final router = locator<AppRouter>();
  Future<void> submitKyc() async {
    setBusyAndNotify(true);
    await Future.delayed(const Duration(seconds: 2));
    await authService.verifyUser().then((value) {
      print('KYC Verification Successful');
      router.replace(AppRoute());
    });
    setBusyAndNotify(false);
  }
}
