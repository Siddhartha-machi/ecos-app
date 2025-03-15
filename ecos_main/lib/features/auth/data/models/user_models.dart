import 'package:uuid/uuid.dart';

import 'package:ecos_main/features/auth/constants/enums/user_enums.dart';
import 'package:ecos_main/shared/models/base_models.dart';

const uuid = Uuid();

class User extends BaseDataModel {
  final String id;
  final String email;
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
    required this.email,
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

  factory User.fromJSON(Map<String, dynamic> data) {
    return User(
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      dateOfBirth: DateTime.parse(data['dateOfBirth']),
      dateJoined: DateTime.parse(data['dateJoined']),
      lastActiveOn: DateTime.parse(data['lastActiveOn']),
      role: Role.values.firstWhere(
          (e) => e.toString() == 'Role.${data['role']}',
          orElse: () => Role.user),
      password: data['password'],
      profilePictureURL: data['profilePictureURL'],
      bio: data['bio'],
    );
  }

  @override
  Map<String, dynamic> get toMinJSON {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> get toJSON {
    return {
      'id': id,
      ...toMinJSON,
      'dateJoined': dateJoined.toIso8601String(),
      'lastActiveOn': lastActiveOn.toIso8601String(),
      'password': password,
      'profilePictureURL': profilePictureURL,
      'bio': bio,
      'preferences': preferences.toJSON,
    };
  }
}

class Preferences extends BaseDataModel {
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

  factory Preferences.fromJSON(Map<String, dynamic> data) {
    return Preferences(
      themeMode: Theme.values.firstWhere(
          (e) => e.toString() == data['themeMode'],
          orElse: () => Theme.system),
      savemode: SaveMode.values.firstWhere(
          (e) => e.toString() == data['savemode'],
          orElse: () => SaveMode.remote),
      allowDataShare: data['allowDataShare'] ?? false,
      notificationsEnabled: data['notificationsEnabled'] ?? false,
      localRepoConfig: data['localRepoConfig'] != null
          ? LocalRepoConfig.fromJSON(data['localRepoConfig'])
          : null,
    );
  }

  @override
  Map<String, dynamic> get toMinJSON {
    return {
      'themeMode': themeMode.toString(),
      'savemode': savemode.toString(),
      'allowDataShare': allowDataShare,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  @override
  Map<String, dynamic> get toJSON {
    return {
      ...toMinJSON,
      'localRepoConfig': localRepoConfig?.toJSON,
    };
  }
}

class LocalRepoConfig extends BaseDataModel {
  final String path;
  final DateTime lastAccessed;
  // TODO revisit

  const LocalRepoConfig({
    required this.path,
    required this.lastAccessed,
  });

  factory LocalRepoConfig.fromJSON(Map<String, dynamic> data) {
    return LocalRepoConfig(
      path: data['path'],
      lastAccessed: data['lastAccessed'],
    );
  }

  @override
  Map<String, dynamic> get toMinJSON {
    return {
      'path': path,
      'lastAccessed': lastAccessed,
    };
  }

  @override
  Map<String, dynamic> get toJSON => toMinJSON;
}
