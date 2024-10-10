import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/app_wrapper.dart';
import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/view/account/account_view.dart';
import 'package:swiftx_app/view/choose/choose_view.dart';
import 'package:swiftx_app/view/home/home_view.dart';
import 'package:swiftx_app/view/login/login_view.dart';
import 'package:swiftx_app/view/send/send_view.dart';
import 'package:swiftx_app/view/signup/signup_view.dart';
import 'package:swiftx_app/view/welcome/welcome_view.dart';

part 'app_router.gr.dart';

const HomeTab = EmptyShellRoute("HomeTab");
const ExchangeTab = EmptyShellRoute("ExchangeTab");
const TransactionTab = EmptyShellRoute("TransactionTab");
const ProfileTab = EmptyShellRoute("ProfileTab");

@AutoRouterConfig(
  replaceInRouteName: "View,Route",
)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: AppRoute.page, initial: true, children: [
          AutoRoute(page: HomeTab.page, path: 'home', children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: SendRoute.page, path: 'send'),
            AutoRoute(page: ChooseRoute.page, path: 'choose'),
          ]),
          AutoRoute(page: ExchangeTab.page, path: 'exchange'),
          AutoRoute(page: TransactionTab.page, path: 'transaction'),
          AutoRoute(page: ProfileTab.page, path: 'profile', children: [
            AutoRoute(page: AccountRoute.page, initial: true),
          ]),
        ]),
      ];

  @override
  // TODO: implement guards
  List<AutoRouteGuard> get guards => [
        AuthGuard(),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final _authService = locator<AuthService>();
    final isAuthenticated = _authService.isUserSignedIn();
    debugPrint('isAuthenticated: $isAuthenticated');
    if (isAuthenticated) {
      if ([WelcomeRoute.name, LoginRoute.name, SignUpRoute.name]
          .contains(resolver.route.name)) {
        router.push(AppRoute());
      } else {
        resolver.next();
      }
    } else {
      if ([WelcomeRoute.name, LoginRoute.name, SignUpRoute.name]
          .contains(resolver.route.name)) {
        resolver.next();
      } else {
        router.push(WelcomeRoute());
      }
    }
  }
}
