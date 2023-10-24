import 'dart:convert';
import 'package:skywatch_application/data/constants/constants.dart';
import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
class WeatherRepositoryImpl implements WeatherRepository {
  final LocationDrive locationDrive;
  final HttpDrive httpDrive;
  WeatherRepositoryImpl({
    required this.locationDrive,
    required this.httpDrive,
  });
  String? sessionToken;

  @override
  Future<LocationEntity> getCurrentLocation() async => await locationDrive.getLocation();

  @override
  Future<AddressEntity> getCurrentAddress(LocationEntity entity) async {
    final response = await httpDrive
        .get(HttpPaths.getAddressQuery(entity.latitude, entity.longitude));

    return AddressModel.fromJson(jsonDecode(response)['address']);
  }

  @override
  Future<String> getAccessToken() async {
    String basicAuth = 'Basic ${base64.encode(utf8.encode('${HttpPaths.weatherUser}:${HttpPaths.weatherPassword}'))}';
    final response = await httpDrive.get(HttpPaths.getWeatherQuery,
        headers: <String, String>{'authorization': basicAuth});

    return sessionToken = jsonDecode(response)['access_token'];
  }

  @override
  Future<ForecastEntity> getWeeklyForecast(LocationEntity entity) async {
    List<int>? descriptions;
    if (sessionToken == null) await getAccessToken();

    final response = await httpDrive
        .get(_buildWeatherPath(entity), queryParameters: <String, String>{'access_token': sessionToken!});

    final data = jsonDecode(response)["data"];

    if (data.length > 1) {
      descriptions =
          data[1]['coordinates'][0]['dates'].map<int>((json) => int.parse(json['value'].toString())).toList();
    }

    return ForecastModel.fromJson(data[0]['coordinates'][0], descriptions: descriptions);
  }

  String _buildWeatherPath(LocationEntity entity) => HttpPaths.getWeatherPath(
        altitude: entity.altitude.toInt(),
        lat: entity.latitude,
        lng: entity.longitude,
        date: entity.time ?? DateTime.now(),
      );
}
