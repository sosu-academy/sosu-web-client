import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpClient {
  static const BASE_URL = "https://node.qtzz.synology.me";

  Future<String> fetchTest() async {
    final res = await http.get(Uri.parse("$BASE_URL/api/til/goods?pageNo=1"), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Access-Control-Allow-Headers":
          "Origin, X-Requested-With, Content-Type, Accept"
    });
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception("Error");
    }
  }
}
