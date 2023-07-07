import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? bearerToken,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      if (bearerToken != null) "Authorization": "Bearer $bearerToken",
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    dynamic query,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    dynamic query,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    return await dio.delete(url, queryParameters: query, data: data);
  }

    static Future<Response> putData({
    required String url,
    dynamic query,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}