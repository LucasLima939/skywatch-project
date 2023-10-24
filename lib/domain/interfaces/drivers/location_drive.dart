import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class LocationDrive {
  Future<bool> requestPermission();
  Future<LocationEntity> getLocation();
}