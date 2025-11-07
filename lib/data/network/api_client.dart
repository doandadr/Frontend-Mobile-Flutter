import 'package:dio/dio.dart';
import 'package:frontend_mobile_flutter/data/network/api_interceptor.dart';
import 'package:frontend_mobile_flutter/env/env.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  )..interceptors.add(ApiInterceptor());
}
