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
  late AddressAdapterMock addressAdapterMock;
  late HttpAdapterMock httpAdapterMock;
  late LocationModel locationResult;
  late AddressModel addressResult;
  late ForecastModel forecastResult;
  late String weatherPath;

  final exception = Exception();
  const startDate = '2023-10-22T00:00:00Z';
  const endDate = '2023-10-26T00:00:00Z';

  setUp(() {
    locationAdapterMock = LocationAdapterMock();
    addressAdapterMock = AddressAdapterMock();
    httpAdapterMock = HttpAdapterMock();
    sut = WeatherRepositoryImpl(
      locationDrive: locationAdapterMock,
      addressDrive: addressAdapterMock,
      httpDrive: httpAdapterMock,
    );
    locationResult = const LocationModel.empty();
    addressResult = const AddressModel.empty();
    forecastResult = ForecastModel.empty();
    weatherPath = HttpPaths.getWeatherPath(
      altitude: locationResult.altitude!.toInt(),
      lat: locationResult.latitude!,
      lng: locationResult.longitude!,
      formattedStartDate: startDate,
      formattedEndDate: endDate,
    );
    locationAdapterMock.getLocationStub(locationResult);
    addressAdapterMock.getAddressStub(locationResult.latitude!, locationResult.longitude!, addressResult);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(HttpPaths.getWeatherAuth));
  });

  group('Current location', () {
    test('Should get current location correctly', () async {
      final result = await sut.getCurrentLocation();

      expect(result, locationResult);
    });

    test('Should throw exception if has some', () async {
      final result = sut.getCurrentLocation();

      expect(result, throwsA(exception));
    });
  });

  group('Current Address', () {
    test('Should get current address correctly', () async {
      final result = await sut.getCurrentAddress(locationResult);

      expect(result, addressResult);
    });

    test('Should throw exception if has some', () async {
      final result = sut.getCurrentAddress(locationResult);

      expect(result, throwsA(exception));
    });
  });

  group('Weekly Forecast', () {
    setUp(() {
      httpAdapterMock.getUrlStub(HttpPaths.getWeatherAuth, jsonEncode(HttpResponses.oAuthWeatherResponse),
          headers: <String, String>{'Authorization': 'Basic username:password'});

      httpAdapterMock.getUrlStub(weatherPath, jsonEncode(HttpResponses.forecastResponse),
          queryParameters: <String, String>{'access_token': 'access_token'});
    });
    test('Should get accessToken if has none', () async {
      sut.weatherToken = null;

      await sut.getWeeklyForecast(locationResult);

      verify(() => sut.getAccessToken()).called(1);
    });
    test('Should get current weekly forecast correctly', () async {
      final result = await sut.getWeeklyForecast(locationResult);

      expect(result, forecastResult);
    });

    test('Should throw exception if has some', () async {
      final result = sut.getWeeklyForecast(locationResult);

      expect(result, throwsA(exception));
    });
  });
}
