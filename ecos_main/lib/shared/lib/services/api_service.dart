import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shared/utils/global.dart';
import 'package:shared/models/service_models.dart';
import 'package:shared/constants/services_constants.dart';


class APIService {
  static const _baseUrl = "http://localhost:3000/";
  static const _storage = FlutterSecureStorage();

  static bool _isRefreshing = false;
  static bool _isOnline = false;

  static final _connectivity = Connectivity();
  static final List<Completer<Response>> _retryQueue = [];
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
  ));

  APIService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (Global.isSafe(token)) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException error, handler) async {
          switch (error.response?.statusCode) {
            case StatusCodes.badRequest:
              debugPrint("Bad Request: ${error.response?.data}");
              break;
            case StatusCodes.unauthorized:
              await _handleAuthTokenRefresh();
              handler.resolve(await _retryRequest(error.requestOptions));
              return;
            case StatusCodes.forbidden:
              await _storage.delete(key: "auth_token");
              break;
            case StatusCodes.notFound:
              break;
            default:
              debugPrint("Server Error: ${error.response?.statusCode}");
          }
          handler.next(error);
        },
      ),
    );
    _monitorConnectivity();
  }

  /// Checks if the device connections include WiFi or mobile data
  bool _checkConnectivity(List<ConnectivityResult> status) {
    return [ConnectivityResult.wifi, ConnectivityResult.mobile]
        .fold(false, (prev, cT) => prev || status.contains(cT));
  }

  bool _hasSuccessStatusCode(Response<dynamic> response) {
    return Global.isSafe(response.statusCode) && response.statusCode! < 300;
  }

  /// Retrieves the stored authentication token
  Future<String?> _getToken() async => await _storage.read(key: "auth_token");

  /// Handles token refresh logic when a 401 Unauthorized error occurs
  Future<void> _handleAuthTokenRefresh() async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    try {
      final response = await _dio.post('/auth/refresh');
      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        await _storage.write(key: "auth_token", value: newToken);
      } else {
        await _storage.delete(key: "auth_token");
      }
    } catch (_) {
      await _storage.delete(key: "auth_token");
    } finally {
      _isRefreshing = false;
      for (final completer in _retryQueue) {
        completer.complete(_retryRequest(completer.future as RequestOptions));
      }
      _retryQueue.clear();
    }
  }

  /// Monitors if the device is offline and if not runs any queued requests
  Future<void> _monitorConnectivity() async {
    _connectivity.onConnectivityChanged.listen((status) async {
      _isOnline = _checkConnectivity(status);
      if (_isOnline) {
        for (final completer in _retryQueue) {
          completer.complete(_retryRequest(completer.future as RequestOptions));
        }
        _retryQueue.clear();
      }
    });
  }

  /// Retries a failed request after token refresh
  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    return await _dio.fetch(requestOptions);
  }

  /// Sends an HTTP request with optional parameters, data, and file uploads
  Future<APIResponse> request(
    String path, {
    String method = HttpMethod.get,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    List<File>? files,
  }) async {
    APIResponse result;
    try {
      if (!Global.isEmpty(files)) {
        final formData = FormData();
        for (final file in files!) {
          formData.files
              .add(MapEntry('files', await MultipartFile.fromFile(file.path)));
        }
        data = formData as Map<String, dynamic>?;
      }
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      debugPrint('$method : $_baseUrl$path => ${response.statusCode}');

      result = APIResponse(
        isRequestSuccess: _hasSuccessStatusCode(response),
        data: response.data['data'],
        hasPagination: _hasNextPage(response.data),
        currentPage: response.data['current_page'],
        prevPage: response.data['prev_page'],
        nextPage: response.data['next'],
      );
    } catch (error) {
      // TODO return stack trace in dev and a generic message on prod
      result = APIResponse(isRequestSuccess: false, error: error.toString());
    }

    return result;
  }

  /// Checks if the API response contains a next page URL for pagination
  bool _hasNextPage(Map<String, dynamic> responseData) {
    return responseData.containsKey('next') &&
        Global.isSafe(responseData['next']);
  }
}
