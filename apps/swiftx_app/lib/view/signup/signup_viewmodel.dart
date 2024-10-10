import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class SignUpViewModel extends BaseViewModel {
  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  String _name = '';
  String get name => _name;

  String _phone = '';
  String get phone => _phone;

  String _country = '';

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

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setPhone(PhoneNumber value) {
    _phone = value.phoneNumber!;
    _country = value.isoCode!;
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length < 10) {
      return 'Phone number must be at least 10 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != _password) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> signUp() async {
    setBusyAndNotify(true);
    await authService
        .signUpUser(
      email: _email,
      password: _password,
      name: _name,
      phone: _phone,
    )
        .then((response) {
      setBusyAndNotify(false);
      if (response.user != null) {
        router.push(KycRoute(country: _country));
      } else {
        throw Exception('Invalid email or password');
      }
    });
  }
}
