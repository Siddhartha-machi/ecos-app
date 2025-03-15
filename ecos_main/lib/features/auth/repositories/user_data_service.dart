import 'package:ecos_main/shared/lib/services/api_service.dart';
import 'package:ecos_main/features/auth/data/models/user_models.dart';
import 'package:ecos_main/shared/lib/models/service_models.dart';
import 'package:ecos_main/shared/lib/repositories/base_data_service.dart';
import 'package:ecos_main/shared/lib/constants/services_constants.dart';

class UserDataService implements DataService<User> {
  const UserDataService();

  @override
  String get endPoint => 'user';

  @override
  resolveRequest(APIResponse response) {
    if (response.isRequestSuccess) {
      if (response.data.runtimeType == List) {
        return (response.data as List)
            .map((item) => User.fromJSON(item))
            .toList();
      }
      return User.fromJSON(response.data);
    } else {
      // Throw error from here and let widget handle the error.
      throw Exception(response.error ?? 'Couldn\'t complete request');
    }
  }

  @override
  Future<List<User>> fetchAll() async {
    final apiClient = APIService();
    final response = await apiClient.request(endPoint);

    return resolveRequest(response);
  }

  @override
  Future<User> fetchById(String id) async {
    final apiClient = APIService();
    final response = await apiClient.request('$endPoint/$id');

    return resolveRequest(response);
  }

  @override
  Future<User> createItem(User item) async {
    final apiClient = APIService();
    final response = await apiClient.request(
      endPoint,
      method: HttpMethod.post,
      data: item.toJSON,
    );

    return resolveRequest(response);
  }

  @override
  Future<User> updateItem(String id, User item) async {
    final apiClient = APIService();
    final response = await apiClient.request(
      '$endPoint/$id',
      method: HttpMethod.put,
      data: item.toJSON,
    );

    return resolveRequest(response);
  }

  @override
  Future<bool> deleteItem(String id) async {
    final apiClient = APIService();
    final response = await apiClient.request(
      '$endPoint/$id',
      method: HttpMethod.delete,
    );

    return response.isRequestSuccess;
  }
}
