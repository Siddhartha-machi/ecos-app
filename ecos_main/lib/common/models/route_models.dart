class _AuthRoutes {
  String get login => '/login';
  String get register => '/register';
  String get forgotPassword => '/forgot_password';
  String get changePassword => '/change_password';

  const _AuthRoutes();

  bool isAuthRoute(String path) {
    return path == login ||
        path == register ||
        path == forgotPassword ||
        path == changePassword;
  }
}

class _Extensions {
  String get todo => '/todo';
  String get expenses => '/expenses';
  String get fTracker => '/f-tracker';

  const _Extensions();
}

class Routes {
  static const home = '/';
  static const splashScreen = '/splash-screen';
  static const auth = _AuthRoutes();
  static const extension = _Extensions();
}
