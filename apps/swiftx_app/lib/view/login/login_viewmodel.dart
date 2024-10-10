import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  final authService = locator<AuthService>();

  final router = locator<AppRouter>();

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    setBusyAndNotify(true);
    await authService.signInUser(_email, _password).then((response) {
      setBusyAndNotify(false);
      if (response.user != null) {
        router.replace(AppRoute());
      } else {
        throw Exception('Invalid email or password');
      }
    }).catchError((error) {
      throw Exception(error.toString());
    });
  }
}
