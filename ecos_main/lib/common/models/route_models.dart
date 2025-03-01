class PathConfig {
  final String _root, _path;

  const PathConfig(this._root, this._path);

  const PathConfig.simple(this._root) : _path = '';

  String get path => _path.isEmpty ? _root : _path;
  String get absolutePath => '$_root$_path';
}

class _AuthPaths {
  static const String _root = '/auth';

  PathConfig get root => const PathConfig.simple(_root);
  PathConfig get login => const PathConfig(_root, '/login');

  PathConfig get register => const PathConfig(_root, '/register');
  PathConfig get personalDetails => const PathConfig(_root, '/personalDetails');
  PathConfig get forgotPassword => const PathConfig(_root, '/forgotPassword');
  PathConfig get changePassword => const PathConfig(_root, '/changePassword');

  const _AuthPaths();

  bool isAuthRoute(String path) {
    return path == login.path ||
        path == register.path ||
        path == forgotPassword.path ||
        path == changePassword.path;
  }
}

class _MainPaths {
  const _MainPaths();

  PathConfig get root => const PathConfig.simple('/');
  PathConfig get settings => const PathConfig.simple('/settings');
  PathConfig get profile => const PathConfig.simple('/profile');
}

class Extension {
  final String _root;

  const Extension(this._root);

  PathConfig get root => PathConfig.simple(_root);
  PathConfig get detail => PathConfig(_root, '/detail/:id');
  PathConfig get update => PathConfig(_root, '/update/:id');

  String detailWithId(String id) => '$_root/detail/$id';
  String updateWithId(String id) => '$_root/update/:$id';
}

class ExtensionPaths {
  static const _root = '/extensions';

  const ExtensionPaths();

  PathConfig get root => const PathConfig.simple(_root);
  Extension get todo => const Extension('$_root/todo');
  Extension get eTracker => const Extension('$_root/e-tracker');
  Extension get fTracker => const Extension('$_root/f-tracker');
}

class _Debug {
  const _Debug();

  String get root => '/debug';
}

class Paths {
  static const auth = _AuthPaths();
  static const main = _MainPaths();
  static const extension = ExtensionPaths();
  static const debug = _Debug();
}
