import 'package:get_it/get_it.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/service/auth_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerSingleton<AuthService>(AuthService());
}