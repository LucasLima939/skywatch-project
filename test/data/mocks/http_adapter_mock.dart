import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';

class HttpAdapterMock extends Mock implements HttpDrive {
  When _getUrl(String path, [Map<String, String>? headers, Map<String, String>? queryParameters]) =>
      when(() => get(path, headers: headers, queryParameters: queryParameters));
  void getUrlStub(String path, String response, {Map<String, String>? headers, Map<String, String>? queryParameters}) =>
      _getUrl(path, headers, queryParameters).thenAnswer((_) => response);
  void getUrlStubError(String path, exception, {Map<String, String>? headers, Map<String, String>? queryParameters}) =>
      _getUrl(path, headers, queryParameters).thenAnswer((_) => exception);
}
