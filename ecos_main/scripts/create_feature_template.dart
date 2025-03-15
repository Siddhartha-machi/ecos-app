// ignore_for_file: avoid_print

import 'dart:io';

class FeatureCreator {
  final String featureName;
  int _actionId = 1;
  int _subActionId = 1;

  String get featureNameLowerCase => featureName.toLowerCase();

  FeatureCreator(this.featureName);

  /// Main method to create a new feature.
  void createFeature() {
    print('${_actionId++}: Starting feature creation process...');
    _navigateToFeatureDirectory();
    _validateFolderPath();
    _createFlutterPackage();
    _navigateToPackageDirectory();
    _createFolderStructure();
    _createStartupFiles();
    _printSuccessMessage();
  }

  /// Creates a new Flutter package.
  void _createFlutterPackage() {
    _subActionId = 1; // Reset sub-action ID
    print('${_actionId++}: Creating Flutter package: $featureName...');
    Process.runSync(
        'flutter', ['create', '--template=package', featureNameLowerCase]);
  }

  /// Navigates to the package directory.
  void _navigateToFeatureDirectory() {
    _subActionId = 1; // Reset sub-action ID
    print('$_actionId: Looking for features folder...');
    Directory? targetDirectory =
        _findDirectory(Directory.current, 'features', 0);

    if (targetDirectory != null) {
      Directory.current = targetDirectory.path;
      print('  $_actionId.${_subActionId++}: Found features folder path...');
    } else {
      print(
          '  $_actionId.${_subActionId++}: Folder features not found, looking for lib folder...');
      targetDirectory = _findDirectory(Directory.current, 'lib', 0);
      if (targetDirectory != null) {
        print(
            '  $_actionId.${_subActionId++}: Found lib folder, creating features folder...');
        Directory.current = _createFolder('features').path;
      } else {
        throw ScriptError('Error while searching for directory');
      }
    }
    _actionId++;
  }

  /// Recursively searches for a directory.
  Directory? _findDirectory(Directory root, String folderName, int depth) {
    if (depth > 5) {
      return null;
    }

    try {
      final entities = root.listSync(followLinks: false);
      for (final entity in entities) {
        if (entity is Directory) {
          if (entity.path.endsWith(folderName)) {
            return entity;
          } else {
            final found = _findDirectory(entity, folderName, depth + 1);
            if (found != null) {
              return found;
            }
          }
        }
      }
    } catch (e) {
      throw ScriptError('Error searching for directory: $e');
    }
    return null;
  }

  /// Creates a folder if it does not already exist.
  Directory _createFolder(String path) {
    final directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return directory;
  }

  /// Navigates to the package directory.
  void _navigateToPackageDirectory() {
    _subActionId = 1; // Reset sub-action ID
    print('$_actionId: Navigating to package directory...');
    Directory.current =
        _findDirectory(Directory.current, featureNameLowerCase, 0);

    _actionId++;
  }

  /// Creates the folder structure for the new feature.
  void _createFolderStructure() {
    _subActionId = 1; // Reset sub-action ID
    print('$_actionId: Creating folders inside lib...');
    final libDir = Directory('lib/src');
    libDir.createSync(recursive: true);

    final folders = [
      'data',
      'presentation',
      'utils',
      'enums',
      'state',
      'constants'
    ];
    for (final folder in folders) {
      print('  $_actionId.${_subActionId++}: Creating folder lib/$folder...');
      Directory('lib/$folder').createSync(recursive: true);
    }
    print(
        '  $_actionId.${_subActionId++}: Creating folder lib/presentation/screens...');
    Directory('lib/presentation/screens').createSync(recursive: true);
    print(
        '  $_actionId.${_subActionId++}: Creating folder lib/presentation/widgets...');
    Directory('lib/presentation/widgets').createSync(recursive: true);
    print(
        '  $_actionId.${_subActionId++}: Creating folder lib/data/repositories...');
    Directory('lib/data/repositories').createSync(recursive: true);
    print('  $_actionId.${_subActionId++}: Creating folder lib/data/models...');
    Directory('lib/data/models').createSync(recursive: true);

    _actionId++;
  }

  /// Creates the initial startup files for the new feature.
  void _createStartupFiles() {
    _subActionId = 1; // Reset sub-action ID
    print('$_actionId: Creating startup files...');

    // Data layer
    print('  $_actionId.${_subActionId++}: Creating data service file...');
    _createFile(
      path: 'lib/data/repositories/${featureNameLowerCase}_data_service.dart',
      content:
          '''class ${featureName}DataService {\n  // Add data service methods here\n}''',
    );
    print('  $_actionId.${_subActionId++}: Creating model file...');
    _createFile(
      path: 'lib/data/models/${featureNameLowerCase}_model.dart',
      content:
          '''import 'package:ecos_main/shared/models/base_models.dart';\n\nclass $featureName extends BaseModel {\n  // Add model attributes and methods here\n}''',
    );

    // State layer
    print('  $_actionId.${_subActionId++}: Creating provider root file...');
    _createFile(
      path: 'lib/state/provider_root.dart',
      content: '''// Add all the necessary providers here\n''',
    );

    _actionId++;
  }

  /// Creates a file at the specified path with the provided content.
  void _createFile({required String path, required String content}) {
    File(path).writeAsStringSync(content);
  }

  /// Prints a success message after the feature is created.
  void _printSuccessMessage() {
    print('Feature "$featureName" created successfully!');
    Process.runSync('tree', ['lib'], runInShell: true);
  }

  /// Validates if the folder with the feature name already exists.
  void _validateFolderPath() {
    _subActionId = 1; // Reset sub-action ID
    print('$_actionId: Validating folder path...');
    if (Directory(featureNameLowerCase).existsSync()) {
      throw ScriptError(
          'Can\'t create feature. The folder "$featureNameLowerCase" already exists in the current directory.');
    }
    _actionId++;
  }
}

class ScriptError implements Exception {
  final String message;
  ScriptError(this.message);

  @override
  String toString() => 'Script Error: $message';
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Error: Feature name is required.');
    print('Usage: flutter run scripts/create_feature.dart <feature_name>');
    exit(1);
  }

  final featureName = arguments[0];
  final featureCreator = FeatureCreator(featureName);
  featureCreator.createFeature();
}
