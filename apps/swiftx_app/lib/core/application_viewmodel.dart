import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class ApplicationViewModel extends BaseViewModel {
  late UserModel _user;

  UserModel get user => _user;

  final authService = locator<AuthService>();

  ApplicationViewModel() {
    print("ApplicationViewModel created");
    getData();
  }

  void getData() async {
    setBusyAndNotify(true);
    // Simulate a network request
    await authService.getUserData().then((value) {
      _user = value;
      setBusyAndNotify(false);
    }).catchError((error) {
      print(error);
      setBusyAndNotify(false);
    });
  }
}
