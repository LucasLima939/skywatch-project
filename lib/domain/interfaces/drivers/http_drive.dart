abstract class HttpDrive {
  Future<String> get(String path, {Map<String, String>? headers, Map<String, String>? queryParameters});
}