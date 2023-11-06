import 'package:sosu_web/src/network/http_client.dart';
import 'package:sosu_web/src/utils/j_logger.dart';

import '../models/base_response.dart';
import '../models/goods_entity.dart';

/// Description :
///
/// Created by juhongmin on 10/15/23

class APIs {
  static final HttpClient _client = HttpClient();

  APIs._();

  static Future<ApiResponse> fetchGoods() async {
    final ApiResponse res = await _client
        .get<JSendListWithMeta<GoodsEntity, PaginationMeta>>(
            "/api/til/goods", {"pageNo": "1", "pageSize": "5"});
    if (res is Success) {
      JSendListWithMeta<GoodsEntity, PaginationMeta> data =
          JSendListWithMeta.fromJson(
              res.json,
              (json) => GoodsEntity.fromJson(json),
              (json) => PaginationMeta.fromJson(json));
      res.setData(data);
    }
    return res;
  }

  static Future<ApiResponse> fetchError() async {
    final ApiResponse res = await _client
        .get<JSendObjWithMeta<BaseJson, BaseJson>>("/api/til/error/505", {});

    if (res is Success) {
      JSendObjWithMeta<EmptyEntity, EmptyMeta> data = JSendObjWithMeta.fromJson(
          res.json,
          (json) => EmptyEntity.fromJson(json),
          (json) => EmptyMeta.fromJson(json));
      res.setData(data);
    } else if (res is Fail) {
      JSendObjWithMeta<EmptyEntity, EmptyMeta> data = JSendObjWithMeta.fromJson(
          res.json,
              (json) => EmptyEntity.fromJson(json),
              (json) => EmptyMeta.fromJson(json));
      res.setData(data);
    }

    JLogger.d("$res");

    return res;
  }
}
