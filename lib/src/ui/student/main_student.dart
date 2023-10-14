import 'package:flutter/material.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';
import 'package:sosu_web/src/utils/j_logger.dart';

/// Description : 메인 학생 목록 페이지
///
/// Created by juhongmin on 2023/04/19
class MainStudentPage extends StatelessWidget {
  const MainStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CardStyle.iconTextButton(Icons.add, "학생 신규 추가", () {
              JLogger.d("클릭 클릭");
            })
          ],
        )
      ],
    );
    // return Scaffold(
    //   extendBody: ,
    //   body: Column(
    //     children: const [
    //       Center(child: Text("학생 관리 화면입니다.")),
    //       Center(child: Text("학생 관리 화면입니다.")),
    //       Center(child: Text("학생 관리 화면입니다."))
    //     ],
    //   ),
    // );
  }
}
