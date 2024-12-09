class Global {
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
