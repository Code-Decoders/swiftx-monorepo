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
class ChooseRoute extends PageRouteInfo<ChooseRouteArgs> {
  ChooseRoute({
    Key? key,
    required bool isIncome,
    List<PageRouteInfo>? children,
  }) : super(
          ChooseRoute.name,
          args: ChooseRouteArgs(
            key: key,
            isIncome: isIncome,
          ),
          initialChildren: children,
        );

  static const String name = 'ChooseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChooseRouteArgs>();
      return ChooseView(
        key: args.key,
        isIncome: args.isIncome,
      );
    },
  );
}

class ChooseRouteArgs {
  const ChooseRouteArgs({
    this.key,
    required this.isIncome,
  });

  final Key? key;

  final bool isIncome;

  @override
  String toString() {
    return 'ChooseRouteArgs{key: $key, isIncome: $isIncome}';
  }
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
/// [RequestDetailView]
class RequestDetailRoute extends PageRouteInfo<RequestDetailRouteArgs> {
  RequestDetailRoute({
    Key? key,
    required RequestModel request,
    List<PageRouteInfo>? children,
  }) : super(
          RequestDetailRoute.name,
          args: RequestDetailRouteArgs(
            key: key,
            request: request,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestDetailRouteArgs>();
      return RequestDetailView(
        key: args.key,
        request: args.request,
      );
    },
  );
}

class RequestDetailRouteArgs {
  const RequestDetailRouteArgs({
    this.key,
    required this.request,
  });

  final Key? key;

  final RequestModel request;

  @override
  String toString() {
    return 'RequestDetailRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [RequestView]
class RequestRoute extends PageRouteInfo<void> {
  const RequestRoute({List<PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RequestView();
    },
  );
}

/// generated route for
/// [SendRequestView]
class SendRequestRoute extends PageRouteInfo<SendRequestRouteArgs> {
  SendRequestRoute({
    Key? key,
    required bool isIncome,
    required UserModel recipient,
    required String countryCode,
    List<PageRouteInfo>? children,
  }) : super(
          SendRequestRoute.name,
          args: SendRequestRouteArgs(
            key: key,
            isIncome: isIncome,
            recipient: recipient,
            countryCode: countryCode,
          ),
          initialChildren: children,
        );

  static const String name = 'SendRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendRequestRouteArgs>();
      return SendRequestView(
        key: args.key,
        isIncome: args.isIncome,
        recipient: args.recipient,
        countryCode: args.countryCode,
      );
    },
  );
}

class SendRequestRouteArgs {
  const SendRequestRouteArgs({
    this.key,
    required this.isIncome,
    required this.recipient,
    required this.countryCode,
  });

  final Key? key;

  final bool isIncome;

  final UserModel recipient;

  final String countryCode;

  @override
  String toString() {
    return 'SendRequestRouteArgs{key: $key, isIncome: $isIncome, recipient: $recipient, countryCode: $countryCode}';
  }
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
/// [TransactionDetailView]
class TransactionDetailRoute extends PageRouteInfo<TransactionDetailRouteArgs> {
  TransactionDetailRoute({
    Key? key,
    required TransactionModel transaction,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionDetailRoute.name,
          args: TransactionDetailRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransactionDetailRouteArgs>();
      return TransactionDetailView(
        key: args.key,
        transaction: args.transaction,
      );
    },
  );
}

class TransactionDetailRouteArgs {
  const TransactionDetailRouteArgs({
    this.key,
    required this.transaction,
  });

  final Key? key;

  final TransactionModel transaction;

  @override
  String toString() {
    return 'TransactionDetailRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [TransactionsView]
class TransactionsRoute extends PageRouteInfo<void> {
  const TransactionsRoute({List<PageRouteInfo>? children})
      : super(
          TransactionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TransactionsView();
    },
  );
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
