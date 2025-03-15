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
  PathConfig get extensionList => const PathConfig.simple('/extension-list');
  PathConfig get extensionDetail => const PathConfig('/extension-list', '/:id');
  PathConfig get settings => const PathConfig.simple('/settings');
  PathConfig get profile => const PathConfig.simple('/profile');
}

class ExtensionPath {
  final String _root, _path;

  const ExtensionPath(this._root, this._path);

  PathConfig get root => PathConfig(_root, _path);
  PathConfig get stats => PathConfig('$_root$_path', '/stats');
  PathConfig get settings => PathConfig('$_root$_path', '/settings');
  PathConfig get detail => PathConfig('$_root$_path', '/detail/:id');
  PathConfig get update => PathConfig('$_root$_path', '/update/:id');

  String detailWithId(String id) => '$_root$_path/detail/$id';
  String updateWithId(String id) => '$_root$_path/update/:$id';
}

class ExtensionPaths {
  static const _root = '/your-space';

  const ExtensionPaths();

  PathConfig get root => const PathConfig.simple(_root);
  ExtensionPath get todo => const ExtensionPath(_root, '/todo');
  ExtensionPath get eTracker => const ExtensionPath(_root, '/e-tracker');
  ExtensionPath get fTracker => const ExtensionPath(_root, '/f-tracker');
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
