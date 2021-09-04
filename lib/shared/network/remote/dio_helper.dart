import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  // static Future<Response> getData({
  //   required String path,
  //   Map<String, dynamic>? query,
  //   String lang = 'en',
  //   String? token,
  // }) async {
  //   dio.options.headers = ApiDataAndEndPoints._headers(
  //     lang: lang,
  //     token: token,
  //   );
  //
  //   return await dio.get(
  //     path,
  //     queryParameters: query,
  //   );
  // }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = "ar",
      String? token,
      required Map<String, dynamic> data}) async {
    dio.options = BaseOptions(
      headers: {
        "lang": lang,
        "token": token,
      },
    );
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
