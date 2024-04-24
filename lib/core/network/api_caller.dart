import 'package:dio/dio.dart';

class ApiCaller {
  static String url = 'https://flutter.prominaagency.com/api/';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  );
  static final dio = Dio(opts);

  static Future<Response> getHTTP(String url, [String? token]) async {
    try {
      if (token == null) {
        Response response = await dio.get(url);
        return response;
      } else {
        Response response = await dio.get(url, options: Options(headers: {'Authorization': 'Bearer $token'}));
        return response;
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<Response> postHTTP(String url, dynamic data, [String? token]) async {
    try {
      if (token == null) {
        Response response = await dio.post(url,
            data: data,
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
                headers: {"Accept": "application/json"}));
        return response;
      } else {
        Response response = await dio.post(url,
            data: data,
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
                headers: {"Accept": "application/json", 'Authorization': 'Bearer $token'}));
        return response;
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<Response> putHTTP(String url, dynamic data) async {
    try {
      Response response = await dio.put(url, data: data);
      return response;
    } catch (e) {
      throw Exception();
    }
  }

  static Future<Response> patchHTTP(String url, dynamic data, [String? token]) async {
    try {
      if (token == null) {
        Response response = await dio.patch(
          url,
          data: data,
        );
        return response;
      } else {
        Response response = await dio.patch(url, data: data, options: Options(headers: {'Authorization': 'Bearer $token'}));
        return response;
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<Response> deleteHTTP(String url) async {
    try {
      Response response = await dio.delete(url);
      return response;
    } catch (e) {
      throw Exception();
    }
  }
}
