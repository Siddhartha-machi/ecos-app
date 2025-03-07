import 'package:ecos_main/services/api_service.dart';
import 'package:ecos_main/common/models/service_models.dart';
import 'package:ecos_main/repositories/base_data_service.dart';
import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/common/constants/services_constants.dart';

class ExtensionDetailDataService implements DataService<ExtensionDetail> {
  const ExtensionDetailDataService();

  @override
  String get endPoint => 'extensionDetail';

  @override
  resolveRequest(APIResponse response) {
    if (response.isRequestSuccess) {
      if (response.data.runtimeType == List) {
        return (response.data as List)
            .map((item) => ExtensionDetail.fromJSON(item))
            .toList();
      }
      return ExtensionDetail.fromJSON(response.data);
    } else {
      // Throw error from here and let widget handle the error.
      throw Exception(response.error ?? 'Couldn\'t complete request');
    }
  }

  @override
  Future<List<ExtensionDetail>> fetchAll() async {
    final apiClient = APIService();
    final response = await apiClient.request(endPoint);

    return resolveRequest(response);
  }

  @override
  Future<ExtensionDetail> fetchById(String id) async {
    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return resolveRequest(response);
  }

  @override
  Future<ExtensionDetail> createItem(ExtensionDetail item) async {
    final apiClient = APIService();
    final response = await apiClient.request(
      endPoint,
      method: HttpMethod.post,
      data: item.toJSON,
    );

    return resolveRequest(response);
  }

  @override
  Future<ExtensionDetail> updateItem(String id, ExtensionDetail item) async {
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
