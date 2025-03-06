import 'package:ecos_main/services/api_service.dart';
import 'package:ecos_main/mocks/api_service_mock.dart';
import 'package:ecos_main/common/models/service_models.dart';
import 'package:ecos_main/repositories/base_data_service.dart';
import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/common/constants/services_constants.dart';

class ExtensionDetailDataService implements DataService<ExtensionDetail> {
  final bool _enableMock;

  const ExtensionDetailDataService(bool? enableMock)
      : _enableMock = enableMock ?? false;

  @override
  String get endPoint => 'extensionDetail';

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
  Future<List<ExtensionDetail>> fetchAll() async {
    if (_enableMock) return [];

    final apiClient = APIService();
    final response = await apiClient.request(endPoint);

    return resolveRequest(response);
  }

  @override
  Future<ExtensionDetail> fetchById(String id) async {
    if (_enableMock) return await MockAPIService().request(endPoint);

    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return resolveRequest(response);
  }

  @override
  Future<ExtensionDetail> createItem(ExtensionDetail item) async {
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
  Future<ExtensionDetail> updateItem(String id, ExtensionDetail item) async {
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
