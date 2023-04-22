import 'package:flutter/material.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';

/// Description : 메인 > 디자인 시스템 화면
///
/// Created by juhongmin on 2023/04/19
class MainDesignSystemPage extends StatelessWidget {
  final List<Widget> _views = [];

  MainDesignSystemPage({super.key}) {
    _initViews();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _views.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // showModalBottomSheet(context: context, builder: (BuildContext context) {
            //   return Container(
            //     height: 200.0,
            //     child: TvStyle.t2_B(title: "$index 를 클릭 했습니다."),
            //   );
            // });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Container(
                      height: 300,
                      child: TvStyle.t2_B(title: "$index 를 클릭 했습니다."),
                    ),
                  );
                });
          },
          child: _views[index],
        );
      },
    );
  }

  void _initViews() {
    _views.add(CardStyle.c1(TvStyle.t1_B(title: "TextStyle Type 1"),
        TvStyle.t1(title: "TextStyle Type 1 Bold")));
  }
}
