import 'package:cached_network_image/cached_network_image.dart';
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
    return Text(title, style: style, textAlign: TextAlign.left);
  }
}

typedef OnButtonClickListener<T> = void Function(T data);

class CardStyle {
  static Card c1(Text tvTitle, Text subTitle) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(
        title: tvTitle,
        subtitle: subTitle,
      ),
    ]));
  }

  static Card c1_img(Text tvTitle, Text subTitle, String imgUrl) {
    // 중간에 아래 에러가 발생하면서 이미지 로드를 하지 않음
    // Failed to decode image using the browser's ImageDecoder API.
    // Image source: https://node.qtzz.synology.me/resource/img/20230227/1677463363525o8e0voblm9g.jpg
    // Original browser error: InvalidStateError: Failed to retrieve track metadata.
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: imgUrl.trim(),
            httpHeaders: const {
              "Access-Control-Allow-Headers":
                  "Origin, X-Requested-With, Content-Type, Accept",
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Methods":
                  "POST, GET, OPTIONS, PUT, DELETE, HEAD"
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fitWidth,
          ),
          tvTitle,
          subTitle
        ],
      ),
    );
  }

  /// Icon + Text Button Style
  /// [icon] 왼쪽 아이콘을 넣을 아이콘 데이터
  /// [title] 텍스트 문구
  /// [onClick] 클릭 이벤트 리스너
  static Widget iconTextButton(
      IconData icon, String title, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Card(
        color: Colors.blue,
        elevation: 6,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white,),
              const SizedBox(width: 5),
              TvStyle.t2(title: title,color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
