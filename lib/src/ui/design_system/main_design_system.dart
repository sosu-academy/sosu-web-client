import 'package:flutter/material.dart';

/// Description : 메인 > 디자인 시스템 화면
///
/// Created by juhongmin on 2023/04/19
class MainDesignSystemPage extends StatelessWidget {

  const MainDesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key("HIHI"),
        children: const [
          Center(child: Text("대쉬보드 화면입니다.")),
          Center(child: Text("대쉬보드 화면입니다.")),
          Center(child: Text("대쉬보드 화면입니다."))
        ],
      ),
    );
  }
}