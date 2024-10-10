import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/base_viewmodel.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

class HomeViewModel extends BaseViewModel {
  late UserModel _user;
  UserModel get user => _user;

  final authService = locator<AuthService>();

  HomeViewModel() {
    print("HomeViewModel created");
    getData();
  }

  Future getData() async {
    setBusyAndNotify(true);
    Future.wait([
      authService.getUserData(),
    ]).then((value) {
      _user = value[0] as UserModel;
      setBusyAndNotify(false);
    }).catchError((error) {
      print(error);
      setBusyAndNotify(false);
    });
  }
}
