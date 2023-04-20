import 'package:flutter/material.dart';
import 'package:sosu_web/src/models/base_response.dart';
import 'package:sosu_web/src/models/goods_entity.dart';
import 'package:sosu_web/src/network/http_client.dart';

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
          List<Center> childView = [];
          ApiResponse<PayloadList<GoodsEntity>> response =
              snapshot.data as ApiResponse<PayloadList<GoodsEntity>>;
          List<GoodsEntity> list = response.data?.list ?? [];
          for (var element in list) {
            childView.add(Center(
                child: Text(
                    "${element.uid}_${element.title}_${element.message}")));
          }
          return Scaffold(
            body: Column(
              children: childView,
            ),
          );
        } else if (snapshot.hasError) {
          // 오류 발생 시 처리
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터를 가져오는 중일 때 처리
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: Text("테스트를 위해 서버 딜레이 3초입니다.")),
                Center(child: CircularProgressIndicator())
              ]);
        }
      },
    );
  }
}
