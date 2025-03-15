import 'package:flutter/material.dart';

import 'package:ecos_main/shared/models/service_models.dart';

abstract class DataService<T> {
  String get endPoint;

  // Fetch data
  Future<List<T>> fetchAll();
  Future<T> fetchById(String id);

  // Create a new resource
  Future<T> createItem(T item);

  // Update an existing resource
  Future<T> updateItem(String id, T item);

  // Delete a resource
  Future<bool> deleteItem(String id);

  // Helper methods
  @protected
  resolveRequest(APIResponse response);
}
