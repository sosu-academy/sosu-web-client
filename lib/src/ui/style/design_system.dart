import 'package:flutter/material.dart';

/// Description : 공통 디자인 시스템
/// 텍스트 스타일은 아래로 정의
/// t1 -> fontSize 24
/// t2 -> fontSize 20
/// t3 -> fontSize 16
/// t4 -> fontSize 14
/// t5 -> fontSize 12
/// Created by juhongmin on 2023/04/22
///
class TvStyle {
  static Text t1({required String title, Color color = Colors.black}) {
    return _initText(title, color, 24, FontWeight.normal);
  }

  static Text t1_B(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 24, FontWeight.bold);
  }

  static Text t2(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 20, FontWeight.normal);
  }

  static Text t2_B(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 20, FontWeight.normal);
  }

  static Text t3(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 16, FontWeight.normal);
  }

  static Text t3_B(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 16, FontWeight.normal);
  }

  static Text t4(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 14, FontWeight.normal);
  }

  static Text t4_B(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 14, FontWeight.normal);
  }

  static Text t5(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 12, FontWeight.normal);
  }

  static Text t5_B(
      {required String title, Color color = const Color(0xFF343434)}) {
    return _initText(title, color, 12, FontWeight.normal);
  }

  static Text _initText(
      String title, Color color, double textSize, FontWeight fontWeight) {
    TextStyle style =
        TextStyle(color: color, fontWeight: fontWeight, fontSize: textSize);
    return Text(title, style: style);
  }
}
