import 'package:ecos_main/common/models/user_models.dart';

class MockAPIService {
  Future<dynamic> request(String endpoint, {dynamic data}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 3));

    // Mock responses based on the endpoint
    switch (endpoint) {
      case 'user':
        return User.fromJSON(data['user']);

      case 'delete':
        return true;
      default:
        return [];
    }
  }
}

class MockAPIResponse {
  final bool isRequestSuccess;
  final dynamic data;

  MockAPIResponse({required this.isRequestSuccess, this.data});
}
