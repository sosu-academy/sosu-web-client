
import 'package:dio/dio.dart';
import 'package:sosu_web/src/utils/j_logger.dart';

/// Description : HTTP 통신할때 Interceptor 관련 클래스들
///
/// Created by juhongmin on 2023/04/21

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    StringBuffer str = StringBuffer();
    str.write('--> ${options.method} ${options.uri}\n');
    str.write('Headers: ${options.headers}\n');
    if (options.data != null) {
      str.write('Body: ${options.data}');
    }
    JLogger.d(str.toString());
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    StringBuffer str = StringBuffer();
    str.write('<-- Error -->');
    str.write('URI: ${err.requestOptions.uri}\n');
    str.write('$err');
    JLogger.d(str.toString());
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    StringBuffer str = StringBuffer();
    str.write('<-- ${response.statusCode} ${response.requestOptions.path}\n');
    str.write('Headers: ${response.headers}\n');
    str.write('Response: ${response.data}\n');
    JLogger.d(str.toString());
    handler.next(response);
  }
}

class TokenInterceptor extends Interceptor {
  final String token;

  TokenInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = token;
    handler.next(options);
  }
}
