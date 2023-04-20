import 'package:flutter/material.dart';

/// Description : 메인 학생 관리 페이지
///
/// Created by juhongmin on 2023/04/19
class MainStudentPage extends StatelessWidget {

  const MainStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key("HIHI"),
        children: const [
          Center(child: Text("학생 관리 화면입니다.")),
          Center(child: Text("학생 관리 화면입니다.")),
          Center(child: Text("학생 관리 화면입니다."))
        ],
      ),
    );
  }
}