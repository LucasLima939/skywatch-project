import 'package:location/location.dart';
import 'package:skywatch_application/data/models/location_model.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/entities/location_entity.dart';

class LocationAdapter implements LocationDrive {
  final _location = Location();
  late PermissionStatus _permissionStatus;

  @override
  Future<LocationEntity> getLocation() async {
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) await requestPermission();
    if (_permissionStatus == PermissionStatus.granted || _permissionStatus == PermissionStatus.grantedLimited) {
      final data = await _location.getLocation();
      return LocationModel.fromLocationData(data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> requestPermission() async {
    _permissionStatus = await _location.requestPermission();
    return _permissionStatus == PermissionStatus.granted || _permissionStatus == PermissionStatus.grantedLimited;
  }
}
