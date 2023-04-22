import 'package:flutter/material.dart';
import 'package:sosu_web/src/ui/style/design_system.dart';

/// Description : 메인 > 디자인 시스템 화면
///
/// Created by juhongmin on 2023/04/19
class MainDesignSystemPage extends StatelessWidget {

  final List<Widget> _views = [];

  MainDesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key("HIHI"),
        children: [
          Center(child: TvStyle.t1(title: "TextStyle Type 1", color: Colors.lightGreen)),
          Center(child: TvStyle.t1_B(title: "TextStyle Type 1 볼드체 입니다.")),
          Center(child: TvStyle.t2(title: "TextStyle Type 2"))
        ],
      ),
    );
  }
}