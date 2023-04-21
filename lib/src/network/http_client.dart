import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sosu_web/src/models/base_response.dart';

import '../models/goods_entity.dart';
import 'http_interceptor.dart';

class HttpClient {
  static const BASE_URL = "https://node.qtzz.synology.me";

  late Dio _client;

  Dio initClient() {
    return Dio(BaseOptions(
        baseUrl: "https://node.qtzz.synology.me",
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
          "Content-Type": "application/json; charset=UTF-8"
        },
        connectTimeout: 5000,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        validateStatus: (status) => status! < 500));
  }

  HttpClient._privateConstructor() {
    _client = initClient();
    _client.interceptors
        .addAll([TokenInterceptor("Token Test"), LoggingInterceptor()]);
  }

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<ApiResponse<PayloadList<GoodsEntity>>> fetchGoods() async {
    final Response res = await _client.get("/api/til/goods",
        queryParameters: {"pageNo": "1", "pageSize": "200"});
    await Future.delayed(const Duration(seconds: 1));
    if (res.statusCode == 200) {
      try {
        return ApiResponse<PayloadList<GoodsEntity>>.fromJson(res.data,
            (dataJson) {
          return PayloadList.fromJson(dataJson, (payloadJson) {
            return GoodsEntity.fromJson(payloadJson);
          });
        });
        // 아래 방식이 좀더 코드가 줄어보일수 있지만 나는 좀더 위에 방향인 명확하게 하는걸로 선택
        // return ApiResponse<PayloadList<GoodsEntity>>.fromJson(
        //     json,
        //     (json) => PayloadList.fromJson(
        //         json, (json) => GoodsEntity.fromJson(json)));
      } catch (err) {
        rethrow;
      }
    } else {
      throw ApiErrorException("ApiError");
    }
  }
}
