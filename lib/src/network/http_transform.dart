import 'package:dio/dio.dart';
import 'package:sosu_web/src/models/base_response_v2.dart';

import '../utils/j_logger.dart';

extension ApiTransform on Future {

  /// API 공통 처리 함수
  /// 성공했을때 자동 파싱과 에러헨들링을 처리합니다.
  Future<ApiResponseV2> apiTransform() {
    return then((res) => _handleApiResponse(res))
        .catchError((error) => _handleApiError(error));
    }

  ApiResponseV2 _handleApiResponse<T>(Response res) {
    int code = res.statusCode != null ? res.statusCode! : -1;
    if (code >= 200 && code <= 299) {
      try {
        return SuccessV2(res.data ?? {});
      } catch (err) {
        if (err is Exception) {
          return ErrorV2(message: err.toString());
        } else {
          return ErrorV2();
        }
      }
    } else {
      return ErrorV2(message: res.statusMessage);
    }
  }

  ApiResponseV2 _handleApiError<T>(dynamic error) {
    if (error is DioException) {
      dynamic errorBody = error.response?.data;
      JLogger.d("DioException ${error.response?.data}");
    } else {
      JLogger.d("Other $error");
    }
    return ErrorV2(message: "dd");
  }
}