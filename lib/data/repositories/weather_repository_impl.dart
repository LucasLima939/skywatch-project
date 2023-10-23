
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final LocationDrive locationDrive;
  final AddressDrive addressDrive;
  final HttpDrive httpDrive;
  WeatherRepositoryImpl({
    required this.locationDrive,
    required this.addressDrive,
    required this.httpDrive,
  });
  String? weatherToken;

  @override
  Future<LocationEntity> getCurrentLocation() {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
    
  }

  @override
  Future<AddressEntity> getCurrentAddress(LocationEntity entity) {
    // TODO: implement getCurrentAddress
    throw UnimplementedError();
  }

  @override
  Future<String> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<ForecastEntity> getWeeklyForecast(LocationEntity entity) {
    // TODO: implement getWeeklyForecast
    throw UnimplementedError();
  }
}
