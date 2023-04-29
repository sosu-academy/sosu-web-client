import 'package:flutter/material.dart';
import 'package:sosu_web/src/models/base_response.dart';
import 'package:sosu_web/src/models/goods_entity.dart';
import 'package:sosu_web/src/network/http_client.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';

/// Description : 메인 > 데쉬보드 화면
///
/// Created by juhongmin on 2023/04/19
class MainDashBoardPage extends StatelessWidget {
  const MainDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HttpClient().fetchGoods(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 데이터를 정상적으로 가져왔을 때 처리
        if (snapshot.hasData) {
          ApiResponse<PayloadList<GoodsEntity>> response = snapshot.data;
          List<GoodsEntity> list = response.data?.list ?? [];
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return CardStyle.c1_img(TvStyle.t2_B(title: item.title),
                    TvStyle.t4(title: item.message), item.imageUrl);
                return ListTile(
                    title: Text("${list[index].title}_${list[index].message}"));
              });
        } else if (snapshot.hasError) {
          // 오류 발생 시 처리
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터를 가져오는 중일 때 처리
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
