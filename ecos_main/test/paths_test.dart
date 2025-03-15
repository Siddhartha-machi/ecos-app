import 'package:flutter_test/flutter_test.dart';

import 'package:ecos_main/core/data/models/route_models.dart';

void main() {
  group('PathConfig', () {
    test('should return correct path and absolutePath for PathConfig', () {
      const pathConfig = PathConfig('/root', '/path');
      expect(pathConfig.path, '/path');
      expect(pathConfig.absolutePath, '/root/path');
    });

    test('should return correct path and absolutePath for PathConfig.simple',
        () {
      const pathConfig = PathConfig.simple('/root');
      expect(pathConfig.path, '/root');
      expect(pathConfig.absolutePath, '/root');
    });
  });

  group('Auth Paths', () {
    const authPaths = Paths.auth;

    test('should return correct paths for auth routes', () {
      expect(authPaths.root.path, '/auth');
      expect(authPaths.login.path, '/login');
      expect(authPaths.register.path, '/register');
      expect(authPaths.personalDetails.path, '/personalDetails');
      expect(authPaths.forgotPassword.path, '/forgotPassword');
      expect(authPaths.changePassword.path, '/changePassword');
    });

    test('isAuthRoute should return true for auth routes', () {
      expect(authPaths.isAuthRoute('/login'), isTrue);
      expect(authPaths.isAuthRoute('/register'), isTrue);
      expect(authPaths.isAuthRoute('/forgotPassword'), isTrue);
      expect(authPaths.isAuthRoute('/changePassword'), isTrue);
    });

    test('isAuthRoute should return false for non-auth routes', () {
      expect(authPaths.isAuthRoute('/invalid'), isFalse);
      expect(authPaths.isAuthRoute('/home'), isFalse);
    });
  });

  group('Main Paths', () {
    const mainPaths = Paths.main;

    test('should return correct paths for main routes', () {
      expect(mainPaths.root.path, '/');
      expect(mainPaths.settings.path, '/settings');
      expect(mainPaths.profile.path, '/profile');
    });
  });

  group('Extension', () {
    const extension = ExtensionPath('/extensions', '/todo');

    test('should return correct paths for extension routes', () {
      expect(extension.root.path, '/todo');
      expect(extension.detail.path, '/detail/:id');
      expect(extension.update.path, '/update/:id');
    });

    test('should return correct paths with IDs', () {
      expect(extension.detailWithId('123'), '/extensions/todo/detail/123');
      expect(extension.updateWithId('123'), '/extensions/todo/update/:123');
    });
  });

  group('ExtensionPaths', () {
    const extensionPaths = ExtensionPaths();

    test('should return correct paths for extension routes', () {
      expect(extensionPaths.root.path, '/your-space');
      expect(extensionPaths.todo.root.path, '/todo');
      expect(extensionPaths.eTracker.root.path, '/e-tracker');
      expect(extensionPaths.fTracker.root.path, '/f-tracker');

      /// Absolute paths
      expect(extensionPaths.todo.root.absolutePath, '/your-space/todo');
      expect(
          extensionPaths.eTracker.root.absolutePath, '/your-space/e-tracker');
      expect(
          extensionPaths.fTracker.root.absolutePath, '/your-space/f-tracker');
    });
    test('should return correct custom paths for extension routes', () {
      expect(extensionPaths.todo.stats.path, '/stats');
      expect(extensionPaths.todo.settings.path, '/settings');
      expect(extensionPaths.todo.detail.path, '/detail/:id');
      expect(extensionPaths.todo.update.path, '/update/:id');

      expect(extensionPaths.todo.stats.absolutePath, '/your-space/todo/stats');
      expect(extensionPaths.todo.settings.absolutePath,
          '/your-space/todo/settings');
      expect(extensionPaths.todo.detail.absolutePath,
          '/your-space/todo/detail/:id');
      expect(extensionPaths.todo.update.absolutePath,
          '/your-space/todo/update/:id');
    });
  });

  group('Paths', () {
    test('should provide access to all path configurations', () {
      expect(Paths.auth, isA<Object>());
      expect(Paths.main, isA<Object>());
      expect(Paths.extension, isA<ExtensionPaths>());
    });
  });
}
