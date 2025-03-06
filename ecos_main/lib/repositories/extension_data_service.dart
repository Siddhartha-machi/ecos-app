import 'package:ecos_main/services/api_service.dart';
import 'package:ecos_main/mocks/api_service_mock.dart';
import 'package:ecos_main/common/models/service_models.dart';
import 'package:ecos_main/repositories/base_data_service.dart';
import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/common/constants/services_constants.dart';

class ExtensionDataService implements DataService<Extension> {
  final bool _enableMock;

  const ExtensionDataService(bool? enableMock)
      : _enableMock = enableMock ?? false;

  @override
  String get endPoint => 'extension';

  @override
  resolveRequest(APIResponse response) {
    if (response.isRequestSuccess) {
      return response.data;
    } else {
      // Throw error from here and let widget handle the error.
      throw Exception(response.error ?? 'Couldn\'t complete request');
    }
  }

  @override
  Future<List<Extension>> fetchAll() async {
    if (_enableMock) return [];

    final apiClient = APIService();
    final response = await apiClient.request(endPoint);

    return resolveRequest(response);
  }

  @override
  Future<Extension> fetchById(String id) async {
    if (_enableMock) return await MockAPIService().request(endPoint);

    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return resolveRequest(response);
  }

  @override
  Future<Extension> createItem(Extension item) async {
    if (_enableMock) return await MockAPIService().request(endPoint);

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
    if (_enableMock) return await MockAPIService().request(endPoint);

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
    if (_enableMock) return await MockAPIService().request('delete');

    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return response.isRequestSuccess;
  }
}
