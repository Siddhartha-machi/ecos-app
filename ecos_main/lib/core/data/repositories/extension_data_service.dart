import 'package:ecos_main/services/api_service.dart';
import 'package:ecos_main/shared/models/service_models.dart';
import 'package:ecos_main/shared/repositories/base_data_service.dart';
import 'package:ecos_main/core/data/models/extension_models.dart';
import 'package:ecos_main/shared/constants/services_constants.dart';

class ExtensionDataService implements DataService<Extension> {
  const ExtensionDataService();

  @override
  String get endPoint => 'extension';

  @override
  resolveRequest(APIResponse response) {
    if (response.isRequestSuccess) {
      if (response.data.runtimeType == List) {
        return (response.data as List)
            .map((item) => Extension.fromJSON(item))
            .toList();
      }
      return Extension.fromJSON(response.data);
    } else {
      // Throw error from here and let widget handle the error.
      throw Exception(response.error ?? 'Couldn\'t complete request');
    }
  }

  @override
  Future<List<Extension>> fetchAll() async {
    final apiClient = APIService();
    final response = await apiClient.request(endPoint);

    return resolveRequest(response);
  }

  @override
  Future<Extension> fetchById(String id) async {
    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return resolveRequest(response);
  }

  @override
  Future<Extension> createItem(Extension item) async {
    final apiClient = APIService();
    final response = await apiClient.request(
      endPoint,
      method: HttpMethod.post,
      data: item.toJSON,
    );

    return resolveRequest(response);
  }

  @override
  Future<Extension> updateItem(String id, Extension item) async {
    final apiClient = APIService();
    final response = await apiClient.request(
      '$endPoint/$id',
      method: HttpMethod.post,
      data: item.toJSON,
    );

    return resolveRequest(response);
  }

  @override
  Future<bool> deleteItem(String id) async {
    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return response.isRequestSuccess;
  }
}
