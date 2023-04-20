import 'package:flutter/material.dart';

/// Description : 메인 >
///
/// Created by juhongmin on 2023/04/19
class MainTablePage extends StatelessWidget {

  const MainTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key("HIHI"),
        children: const [
          Center(child: Text("테이블 화면입니다.")),
          Center(child: Text("테이블 화면입니다.")),
          Center(child: Text("테이블 화면입니다."))
        ],
      ),
    );
  }
}