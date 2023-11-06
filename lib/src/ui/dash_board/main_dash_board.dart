import 'package:flutter/material.dart';
import 'package:sosu_web/src/models/base_response.dart';
import 'package:sosu_web/src/models/goods_entity.dart';
import 'package:sosu_web/src/network/apis.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';
import 'package:sosu_web/src/utils/j_logger.dart';

/// Description : 메인 > 데쉬보드 화면
///
/// Created by juhongmin on 2023/04/19
class MainDashBoardPage extends StatelessWidget {
  const MainDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          initChildrenDashboard(),
          initTest(),
          initErrorTest(),
          CardStyle.c1(TvStyle.t2(title: "3/29 수납예정 학생", color: Colors.blue),
              TvStyle.t4(title: "4명")),
          Center(child: Text("대쉬보드 화면입니다."))
        ],
      ),
    );
  }

  Widget initChildrenDashboard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: CardStyle.c1(
                TvStyle.t2(title: "3/29 수납예정 학생", color: Colors.blue),
                TvStyle.t4(title: "4명"))),
        Flexible(
            child: CardStyle.c1(
                TvStyle.t2(title: "현재 수강료 체납 학생", color: Colors.blue),
                TvStyle.t4(title: "2명"))),
        Flexible(
            child: CardStyle.c1(
                TvStyle.t2(title: "3월 신규생 수", color: Colors.blue),
                TvStyle.t4(title: "3명")))
      ],
    );
  }

  Widget initTest() {
    return FutureBuilder(
        future: APIs.fetchGoods(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 데이터를 정상적으로 가져왔을 때 처리
          if (snapshot.hasData) {
            ApiResponse res = snapshot.data;
            if (res is Success) {
              JSendListWithMeta<GoodsEntity,PaginationMeta> data = res.getData();
              return TvStyle.t4(title: data.getList()[0].message);
            } else {
              return TvStyle.t4(title: res.toString());
            }
          } else if (snapshot.hasError) {
            return TvStyle.t4(title: "ERROR ${snapshot.error}");
          } else {
            // 대기중일때
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget initErrorTest() {
    return FutureBuilder(
        future: APIs.fetchError(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            ApiResponse res = snapshot.data;
            JLogger.d("initErrorTest $res");
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

// TEST
// @override
// Widget build(BuildContext context) {
//   return FutureBuilder(
//     future: HttpClient().fetchGoods(),
//     builder: (BuildContext context, AsyncSnapshot snapshot) {
//       // 데이터를 정상적으로 가져왔을 때 처리
//       if (snapshot.hasData) {
//         ApiResponse<PayloadList<GoodsEntity>> response = snapshot.data;
//         List<GoodsEntity> list = response.data?.list ?? [];
//         return ListView.builder(
//             itemCount: list.length,
//             itemBuilder: (context, index) {
//               final item = list[index];
//               return CardStyle.c1_img(TvStyle.t2_B(title: item.title),
//                   TvStyle.t4(title: item.message), item.imageUrl);
//               return ListTile(
//                   title: Text("${list[index].title}_${list[index].message}"));
//             });
//       } else if (snapshot.hasError) {
//         // 오류 발생 시 처리
//         return Text('Error: ${snapshot.error}');
//       } else {
//         // 데이터를 가져오는 중일 때 처리
//         return const Center(child: CircularProgressIndicator());
//       }
//     },
//   );
// }
}
