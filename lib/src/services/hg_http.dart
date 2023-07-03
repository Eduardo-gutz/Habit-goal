import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class HttpAPI {
  Future<dynamic> get(String url, {Map<String, String>? headers});
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
  Future<dynamic> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
  Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
}

class HGHttp implements HttpAPI {
  String baseUrl = 'http://10.0.2.2:8000/';
  String suffix;
  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    http.Response response =
        await http.get(Uri.parse('$baseUrl$suffix$url'), headers: headers);

    return _handleResponse(response);
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    http.Response response = await http.post(Uri.parse('$baseUrl$suffix$url'),
        body: body, headers: headers);

    return _handleResponse(response);
  }

  @override
  Future<dynamic> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    http.Response response = await http.put(Uri.parse('$baseUrl$suffix$url'),
        body: body, headers: headers);

    return _handleResponse(response);
  }

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    http.Response response = await http.delete(Uri.parse('$baseUrl$suffix$url'),
        body: body, headers: headers);

    return _handleResponse(response);
  }

  _handleResponse(http.Response response) {
    final jsonResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonResponse['detail']);
    }

    return jsonResponse;
  }

  HGHttp({
    required this.suffix,
  });
}
