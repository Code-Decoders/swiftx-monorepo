import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/app_wrapper.dart';
import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/model/request_model.dart';
import 'package:swiftx_app/core/model/transaction_model.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/view/account/account_view.dart';
import 'package:swiftx_app/view/choose/choose_view.dart';
import 'package:swiftx_app/view/home/home_view.dart';
import 'package:swiftx_app/view/kyc/kyc_view.dart';
import 'package:swiftx_app/view/login/login_view.dart';
import 'package:swiftx_app/view/request/request_view.dart';
import 'package:swiftx_app/view/request_detail/request_detail_view.dart';
import 'package:swiftx_app/view/send_request/send_request_view.dart';
import 'package:swiftx_app/view/signup/signup_view.dart';
import 'package:swiftx_app/view/transaction_detail/transaction_detail_view.dart';
import 'package:swiftx_app/view/transactions/transactions_view.dart';
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
        AutoRoute(page: KycRoute.page),
        AutoRoute(page: AppRoute.page, initial: true, children: [
          AutoRoute(
              page: HomeTab.page,
              path: 'home',
              maintainState: false,
              children: [
                AutoRoute(
                    page: HomeRoute.page, initial: true, maintainState: false),
                AutoRoute(page: SendRequestRoute.page, path: 'send'),
                AutoRoute(page: ChooseRoute.page, path: 'choose'),
                AutoRoute(page: TransactionDetailRoute.page)
              ]),
          AutoRoute(
              page: ExchangeTab.page,
              path: 'exchange',
              maintainState: false,
              children: [
                AutoRoute(
                    page: RequestRoute.page,
                    initial: true,
                    maintainState: false),
                AutoRoute(page: RequestDetailRoute.page)
              ]),
          AutoRoute(
              page: TransactionTab.page,
              path: 'transaction',
              maintainState: false,
              children: [
                AutoRoute(
                    page: TransactionsRoute.page,
                    initial: true,
                    maintainState: false),
                AutoRoute(page: TransactionDetailRoute.page)
              ]),
          AutoRoute(page: ProfileTab.page, path: 'profile', children: [
            AutoRoute(page: AccountRoute.page, initial: true),
          ]),
        ]),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        AuthGuard(),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authService = locator<AuthService>();
    final isAuthenticated = authService.isUserSignedIn();
    debugPrint('isAuthenticated: $isAuthenticated');
    if (isAuthenticated) {
      if ([WelcomeRoute.name, LoginRoute.name, SignUpRoute.name]
          .contains(resolver.route.name)) {
        router.push(const AppRoute());
      } else {
        resolver.next();
      }
    } else {
      if ([WelcomeRoute.name, LoginRoute.name, SignUpRoute.name, KycRoute.name]
          .contains(resolver.route.name)) {
        resolver.next();
      } else {
        router.push(const WelcomeRoute());
      }
    }
  }
}
