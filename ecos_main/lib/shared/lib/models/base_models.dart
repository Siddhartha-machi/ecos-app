abstract class BaseDataModel {
  const BaseDataModel();

  /// Converts the model to a minimal JSON representation.
  Map<String, dynamic> get toMinJSON;

  /// Converts the model to a full JSON representation.
  Map<String, dynamic> get toJSON;

  /// Creates a model instance from a JSON map.
  static BaseDataModel fromJSON(Map<String, dynamic> json) {
    throw UnimplementedError('fromJSON() must be implemented in the subclass');
  }
}
