import 'dart:convert';

import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:http/http.dart' as http;

class HttpAdapter implements HttpDrive {
  @override
  Future<String> get(String path, {Map<String, String>? headers, Map<String, String>? queryParameters}) async {
    final uri = Uri.parse(path);

    if (queryParameters != null) uri.queryParameters.addAll(queryParameters);

    final response = await http.get(uri, headers: headers);

    if(response.statusCode >= 200 && response.statusCode < 300){
      return jsonEncode(response.body);
    } else {
      throw Exception();
    }
  }
}
