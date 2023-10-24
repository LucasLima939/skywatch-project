import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class WeatherRepository {
  Future<LocationEntity> getCurrentLocation();
  Future<AddressEntity> getCurrentAddress(LocationEntity entity);
  Future<ForecastEntity> getWeeklyForecast(LocationEntity entity);
  Future<String> getAccessToken();
}