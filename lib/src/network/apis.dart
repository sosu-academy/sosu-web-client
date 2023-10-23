import 'package:sosu_web/src/network/http_client.dart';

import '../models/base_response_v2.dart';
import '../models/goods_entity.dart';

/// Description :
///
/// Created by juhongmin on 10/15/23

class APIs {
  static final HttpClient _client = HttpClient();

  APIs._();

  /// Test API 정적 함수로 하는게 맞는지 잘 모르겠따..
  /// 일단 이렇게 한번 구성해봄
  // static Future<ApiRes> fetchGoods() async {
  //   final ApiRes res = await _client
  //       .get<PayloadList<GoodsEntity>>(
  //           "/api/til/goods", {"pageNo": "1", "pageSize": "5"});
  //   // await Future.delayed(const Duration(seconds: 1));
  //   if (res is Success) {
  //     try {
  //       res.handleJsonMapping((dataJson) {
  //         return PayloadList.fromJson(dataJson, (payloadJson) {
  //           return GoodsEntity.fromJson(payloadJson);
  //         });
  //       });
  //     } catch (err) {
  //       // ignore
  //     }
  //   }
  //   return res;
  // }

  static Future<ApiResponseV2> fetchGoodsV2() async {
    final ApiResponseV2 res = await _client
        .getV2<JSendListWithMeta<GoodsEntityV2, PaginationMeta>>(
            "/api/til/goods", {"pageNo": "1", "pageSize": "5"});
    if (res is SuccessV2) {
      JSendListWithMeta<GoodsEntityV2, PaginationMeta> data =
          JSendListWithMeta.fromJson(
              res.json,
              (json) => GoodsEntityV2.fromJson(json),
              (json) => PaginationMeta.fromJson(json));
      res.setData(data);
    }
    return res;
  }
}
