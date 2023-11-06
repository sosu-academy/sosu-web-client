import 'package:dio/dio.dart';
import 'package:sosu_web/src/models/base_response.dart';

import '../utils/j_logger.dart';

extension ApiTransform on Future {
  /// API 공통 처리 함수
  /// 성공했을때 자동 파싱과 에러헨들링을 처리합니다.
  Future<ApiResponse> apiTransform() {
    return then((res) => _handleApiResponse(res))
        .catchError((error) => _handleApiError(error));
  }

  ApiResponse _handleApiResponse<T>(Response res) {
    int code = res.statusCode != null ? res.statusCode! : -1;
    if (code >= 200 && code <= 299) {
      return Success(res.data ?? "{}");
    } else {
      return Fail(code: code, json: res.data ?? "{}");
    }
  }

  ApiResponse _handleApiError<T>(dynamic err) {
    if (err is DioException) {
      Response? res = err.response;
      // Response Null 일때 에러 타입 추가 해야함
      int? code = res?.statusCode;
      dynamic errorBody = res?.data;
      JLogger.d("DioException [$code] Body $errorBody");
      return Fail(code: code ?? 999, json: errorBody ?? "{}");
    } else {
      JLogger.d("ERROR $err");
      return Error(message: err.toString());
    }
  }
}
