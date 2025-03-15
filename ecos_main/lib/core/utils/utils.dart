// ignore_for_file: constant_identifier_names

class Global {
  // Formatters
  static String capitalize(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }

  static String formattedDate(DateTime date) {
    final ref = DateTime.now();
    final elapsedDays = ref.difference(date).inDays.abs();
    var rValue = 'Several years ago';

    if (elapsedDays == 0) {
      rValue = 'Just now';
    } else if (elapsedDays < 7) {
      rValue = 'A week ago';
    } else if (elapsedDays < 31) {
      rValue = 'A month ago';
    } else if (elapsedDays < 365) {
      rValue = '${(elapsedDays / 30).ceil()} months ago';
    } else {
      final elapsedYears = (elapsedDays / 365).ceil();
      if (elapsedYears < 25) rValue = '$elapsedYears years ago';
    }
    return rValue;
  }

  // Type checkings
  static bool isSafe(value) {
    return value != null;
  }

  static bool isEmpty(value) {
    if (value is String || value is List || value is Map) {
      return value.isEmpty;
    }

    return !Global.isSafe(value);
  }
}

class AppConfig {
  static const String APP_NAME = 'Ecos';
  static const String APP_CAPTION = 'Your personal headquarters';
}
