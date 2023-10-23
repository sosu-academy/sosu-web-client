import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sosu_web/src/models/base_response.dart';

import '../models/base_response_v2.dart';
import 'http_interceptor.dart';

class HttpClient {
  late Dio _client;

  Dio _initClient() {
    // jenkins 에서 Environment 할때 아래 코드 사용할수 있을듯
    // const String myEnv = String.fromEnvironment('TEST_ENV', defaultValue: 'undefined url!');
    // print("TEST $myEnv");
    final String baseUrl = dotenv.env['BASE_URL']!;
    return Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {
          // "Access-Control-Allow-Origin": "*",
          // "Access-Control-Allow-Methods":
          //     "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          // "Access-Control-Allow-Headers":
          //     "Origin, X-Requested-With, Content-Type, Accept",
          "Connection": "keep-alive",
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "*/*"
        },
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        validateStatus: (status) => status! < 500));
  }

  HttpClient._privateConstructor() {
    _client = _initClient();
    _client.interceptors.add(TokenInterceptor("Token Test"));
    // _client.interceptors.add(LoggingInterceptor());
  }

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  ApiRes _handleApiRes<T>(Response res) {
    int statusCode = (res.statusCode != null) ? res.statusCode! : -1;
    if (statusCode >= 200 && statusCode <= 299) {
      try {
        return Success<T>(res.data ?? {});
      } catch (err) {
        if (err is Exception) {
          return Error(message: err.toString());
        } else {
          return Error();
        }
      }
    } else {
      return HttpError(data: res.data);
    }
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

  Future<ApiRes> get<T>(
      String path, Map<String, String>? queryParameters) async {
    final Response res =
        await _client.get(path, queryParameters: queryParameters);
    return _handleApiRes<T>(res);
  }

  Future<ApiResponseV2> getV2<T>(
      String path, Map<String, String>? queryParams) async {
    return _client
        .get(path, queryParameters: queryParams)
        .then((value) => _handleApiResponse(value));
  }

// Future<ApiResponse<PayloadList<GoodsEntity>>> fetchGoods() async {
//   final Response res = await _client.get("/api/til/goods",
//       queryParameters: {"pageNo": "1", "pageSize": "200"});
//   await Future.delayed(const Duration(seconds: 1));
//   if (res.statusCode == 200) {
//     try {
//       return ApiResponse<PayloadList<GoodsEntity>>.fromJson(res.data,
//               (dataJson) {
//             return PayloadList.fromJson(dataJson, (payloadJson) {
//               return GoodsEntity.fromJson(payloadJson);
//             });
//           });
//       // 아래 방식이 좀더 코드가 줄어보일수 있지만 나는 좀더 위에 방향인 명확하게 하는걸로 선택
//       // return ApiResponse<PayloadList<GoodsEntity>>.fromJson(
//       //     json,
//       //     (json) => PayloadList.fromJson(
//       //         json, (json) => GoodsEntity.fromJson(json)));
//     } catch (err) {
//       rethrow;
//     }
//   } else {
//     throw ApiErrorException("ApiError");
//   }
// }
}
