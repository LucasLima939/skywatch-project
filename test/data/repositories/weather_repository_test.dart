import 'dart:convert';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/data/constants/http_paths.dart';
import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/data/repositories/weather_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

main() {
  late WeatherRepositoryImpl sut;
  late LocationAdapterMock locationAdapterMock;
  late HttpAdapterMock httpAdapterMock;
  late LocationModel locationResult;
  late AddressModel addressResult;
  late ForecastModel forecastResult;
  late String weatherPath;

  final exception = Exception();
  const sessionToken = 'access_token';

  ForecastModel buildForecastResponse(json) {
    List<int>? descriptions;
    final data = json["data"];

    if (data.length > 1) {
      descriptions =
          data[1]['coordinates'][0]['dates'].map<int>((json) => int.parse(json['value'].toString())).toList();
    }

    return ForecastModel.fromJson(data[0]['coordinates'][0], descriptions: descriptions);
  }

  setUp(() {
    locationAdapterMock = LocationAdapterMock();
    httpAdapterMock = HttpAdapterMock();
    sut = WeatherRepositoryImpl(
      locationDrive: locationAdapterMock,
      httpDrive: httpAdapterMock,
    );
    locationResult = LocationModel.empty();
    addressResult = AddressModel.fromJson(HttpResponses.addressResponse['address']);
    forecastResult = buildForecastResponse(HttpResponses.forecastResponse);
    weatherPath = HttpPaths.getWeatherPath(
      altitude: locationResult.altitude.toInt(),
      lat: locationResult.latitude,
      lng: locationResult.longitude,
      date: locationResult.time!,
    );
    locationAdapterMock.getLocationStub(locationResult);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(HttpPaths.getWeatherQuery));
  });

  group('Current location', () {
    test('Should get current location correctly', () async {
      final result = await sut.getCurrentLocation();

      expect(result, locationResult);
    });

    test('Should throw exception if has some', () async {
      locationAdapterMock.getLocationStubError(exception);

      final result = sut.getCurrentLocation();

      expect(result, throwsA(exception));
    });
  });

  group('Current Address', () {
    setUp(() {
      httpAdapterMock.getUrlStub(
          HttpPaths.getAddressQuery(locationResult.latitude, locationResult.longitude), jsonEncode(HttpResponses.addressResponse));
    });
    test('Should get current address correctly', () async {
      final result = await sut.getCurrentAddress(locationResult);

      expect(result, addressResult);
    });

    test('Should throw exception if has some', () async {
      httpAdapterMock.getUrlStubError(
          HttpPaths.getAddressQuery(locationResult.latitude, locationResult.longitude), exception);

      final result = sut.getCurrentAddress(locationResult);

      expect(result, throwsA(exception));
    });
  });

  group('Weekly Forecast', () {
    setUp(() {
      httpAdapterMock.getUrlStub(HttpPaths.getWeatherQuery, jsonEncode(HttpResponses.oAuthWeatherResponse),
          headers: <String, String>{'Authorization': 'Basic ${HttpPaths.weatherUser}:${HttpPaths.weatherPassword}'});

      httpAdapterMock.getUrlStub(weatherPath, jsonEncode(HttpResponses.forecastResponse),
          queryParameters: <String, String>{'access_token': sessionToken});

      sut.sessionToken = sessionToken;
    });
    test('Should get accessToken if has none', () async {
      sut.sessionToken = null;

      await sut.getWeeklyForecast(locationResult);

      verify(() => httpAdapterMock.get(HttpPaths.getWeatherQuery, headers: <String, String>{
            'Authorization': 'Basic ${HttpPaths.weatherUser}:${HttpPaths.weatherPassword}'
          })).called(1);
    });
    test('Should get current weekly forecast correctly', () async {
      final result = await sut.getWeeklyForecast(locationResult);

      expect(result, forecastResult);
    });

    test('Should throw exception if has some', () async {
      httpAdapterMock
          .getUrlStubError(weatherPath, exception, queryParameters: <String, String>{'access_token': sessionToken});

      expectLater(sut.getWeeklyForecast(locationResult), throwsA(exception));
    });
  });
}
