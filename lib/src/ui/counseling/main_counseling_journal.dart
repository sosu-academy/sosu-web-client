import 'package:flutter/material.dart';

/// Description : 상담 일지 및 메모
///
/// Created by juhongmin on 2023/04/29
class MainConsultationPage extends StatelessWidget {

  MainConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [Center(child: Text("상담일지 페이지 입니다."))],
      ),
    );
  }
}


class MainMemoPage extends StatelessWidget {

  MainMemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [Center(child: Text("메모 페이지 입니다."))],
      ),
    );
  }
}