import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sosu_web/src/models/base_response.dart';

import '../models/goods_entity.dart';

class HttpClient {
  static const BASE_URL = "https://node.qtzz.synology.me";

  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<String> fetchTest() async {
    final res = await http.get(
        Uri.parse("$BASE_URL/api/til/goods?pageNo=1&pageSize=25"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept"
        });
    if (res.statusCode == 200) {
      jsonDecode(res.body);
      return res.body;
    } else {
      throw Exception("Error");
    }
  }

  Future<ApiResponse<PayloadList<GoodsEntity>>> fetchGoods() async {
    final res = await http.get(
        Uri.parse("$BASE_URL/api/til/goods?pageNo=1&pageSize=200"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept"
        });
    await Future.delayed(const Duration(seconds: 1));
    if (res.statusCode == 200) {
      try {
        final json = jsonDecode(res.body);
        return ApiResponse<PayloadList<GoodsEntity>>.fromJson(json, (dataJson) {
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
