import 'package:uuid/uuid.dart';

import 'package:ecos_main/common/enums/user_enums.dart';

var uuid = const Uuid();

class User {
  final String id;
  final String firstName;
  final String lastName;
  final Role role;
  final DateTime dateOfBirth;
  final DateTime dateJoined;
  final DateTime lastActiveOn;

  final String? password;
  final String? profilePictureURL;
  final String? bio;
  final Preferences preferences;

  User({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.dateJoined,
    required this.lastActiveOn,
    this.role = Role.user,
    this.password,
    this.profilePictureURL,
    this.bio,
  })  : id = uuid.v4(),
        preferences = const Preferences();
}

class Preferences {
  final Theme themeMode;
  final SaveMode savemode;
  final bool allowDataShare;
  final bool notificationsEnabled;

  final LocalRepoConfig? localRepoConfig;

  const Preferences({
    this.themeMode = Theme.system,
    this.savemode = SaveMode.remote,
    this.allowDataShare = false,
    this.notificationsEnabled = false,
    this.localRepoConfig,
  });
}

class LocalRepoConfig {
  final String path;
  final DateTime lastAccessed;
  // TODO revisit

  const LocalRepoConfig({
    required this.path,
    required this.lastAccessed,
  });
}
