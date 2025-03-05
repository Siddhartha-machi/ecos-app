import 'package:ecos_main/services/api_service.dart';
import 'package:ecos_main/mocks/api_service_mock.dart';
import 'package:ecos_main/common/models/user_models.dart';
import 'package:ecos_main/common/models/service_models.dart';
import 'package:ecos_main/repositories/base_data_service.dart';
import 'package:ecos_main/common/constants/services_constants.dart';

class UserDataService implements DataService<User> {
  final bool _enableMock;

  const UserDataService(bool? enableMock) : _enableMock = enableMock ?? false;

  @override
  String get endPoint => 'user';

  _resolveRequest(APIResponse response) {
    if (response.isRequestSuccess) {
      return response.data;
    } else {
      // Throw error from here and let widget handle the error.
      throw Exception(response.error ?? 'Couldn\'t complete request');
    }
  }

  @override
  Future<List<User>> fetchAll() async {
    if (_enableMock) return [];

    final apiClient = APIService();
    final response = await apiClient.request(endPoint);

    return _resolveRequest(response);
  }

  @override
  Future<User> fetchById(String id) async {
    if (_enableMock) return await MockAPIService().request(endPoint);

    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return _resolveRequest(response);
  }

  @override
  Future<User> createItem(User item) async {
    if (_enableMock) return await MockAPIService().request(endPoint);

    final apiClient = APIService();
    final response = await apiClient.request(
      endPoint,
      method: HttpMethod.post,
      data: item.toJSON,
    );

    return _resolveRequest(response);
  }

  @override
  Future<User> updateItem(String id, User item) async {
    if (_enableMock) return await MockAPIService().request(endPoint);

    final apiClient = APIService();
    final response = await apiClient.request(
      '$endPoint/$id',
      method: HttpMethod.post,
      data: item.toJSON,
    );

    return _resolveRequest(response);
  }

  @override
  Future<bool> deleteItem(String id) async {
    if (_enableMock) return await MockAPIService().request('delete');

    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return response.isRequestSuccess;
  }
}
