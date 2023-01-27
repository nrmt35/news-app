import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpClient {
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    http.Response? response;
    final header = <String, String>{
      'Accept': 'application/json',
    }..addAll(headers ?? {});
    var client = http.Client();
    try {
      response = await client.get(
        Uri.parse(url),
        headers: header,
      );
    } on HttpException {
      print(HttpException);
    }
    return json.decode(response!.body);
  }
}
