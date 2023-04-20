import 'package:flutter/material.dart';

/// Description : 메인 > 셋팅 화면
///
/// Created by juhongmin on 2023/04/19
class MainSettingsPage extends StatelessWidget {

  const MainSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key("MainSettingsPage"),
        children: const [
          Center(child: Text("셋팅 화면입니다.")),
          Center(child: Text("대쉬보드 화면입니다.")),
          Center(child: Text("대쉬보드 화면입니다."))
        ],
      ),
    );
  }
}