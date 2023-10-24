import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:http/http.dart' as http;

class HttpAdapter implements HttpDrive {
  @override
  Future<String> get(String path, {Map<String, String>? headers, Map<String, String>? queryParameters}) async {
    final uri = Uri.parse('$path${buildQueryParams(queryParameters)}');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }

  String buildQueryParams(Map<String, String>? queryParameters) {
    final result = queryParameters?.entries.map<String>((entry) => '${entry.key}=${entry.value}').toList().join('&');
    return result != null ? '?$result' : '';
  }
}
