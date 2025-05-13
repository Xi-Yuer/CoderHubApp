import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class _Request {
  String baseURL;
  Duration timeout;
  Map<String, dynamic>? headers;
  Dio dio;

  _Request({
    this.baseURL = '',
    this.timeout = const Duration(seconds: 10),
    this.headers,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseURL,
           connectTimeout: timeout,
           receiveTimeout: timeout,
           headers: headers,
         ),
       ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 请求前拦截：可添加认证 token、打印日志等
          // options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 统一错误处理：可以做提示、重试等
          if (kDebugMode) {
            print("请求失败");
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> request(
    String url, {
    data,
    method = 'get',
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await dio.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options ?? Options(method: method),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // GET 请求封装
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      url,
      method: 'get',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // POST 请求封装
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      url,
      method: 'post',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PUT 请求封装
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      url,
      method: 'put',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // DELETE 请求封装
  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return request(
      url,
      method: 'delete',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

var request = _Request(
  baseURL: 'https://xiyuer.club/',
  timeout: const Duration(seconds: 3),
  headers: {}..addAll({'Content-Type': 'application/json'}),
);

T parseResponse<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) fromJson,
) {
  return fromJson(json);
}
