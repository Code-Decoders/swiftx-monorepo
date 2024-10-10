// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AccountView]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountView();
    },
  );
}

/// generated route for
/// [AppWrapper]
class AppRoute extends PageRouteInfo<void> {
  const AppRoute({List<PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppWrapper();
    },
  );
}

/// generated route for
/// [ChooseView]
class ChooseRoute extends PageRouteInfo<void> {
  const ChooseRoute({List<PageRouteInfo>? children})
      : super(
          ChooseRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChooseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChooseView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [KycView]
class KycRoute extends PageRouteInfo<KycRouteArgs> {
  KycRoute({
    Key? key,
    required String country,
    List<PageRouteInfo>? children,
  }) : super(
          KycRoute.name,
          args: KycRouteArgs(
            key: key,
            country: country,
          ),
          initialChildren: children,
        );

  static const String name = 'KycRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<KycRouteArgs>();
      return KycView(
        key: args.key,
        country: args.country,
      );
    },
  );
}

class KycRouteArgs {
  const KycRouteArgs({
    this.key,
    required this.country,
  });

  final Key? key;

  final String country;

  @override
  String toString() {
    return 'KycRouteArgs{key: $key, country: $country}';
  }
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return LoginView(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SendView]
class SendRoute extends PageRouteInfo<void> {
  const SendRoute({List<PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SendView();
    },
  );
}

/// generated route for
/// [SignUpView]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return SignUpView(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [WelcomeView]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomeView();
    },
  );
}
