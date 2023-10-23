import 'package:location/location.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.altitude,
    required super.latitude,
    required super.longitude,
    required super.time,
  });
  LocationModel.empty() : super(altitude: 0.0, latitude: 0.0, longitude: 0.0, time: DateTime.fromMicrosecondsSinceEpoch(1640901600000000));
  LocationModel.fromLocationData(LocationData data)
      : super(
            altitude: data.altitude ?? 0.0,
            latitude: data.latitude ?? 0.0,
            longitude: data.longitude ?? 0.0,
            time: data.time != null ? DateTime.fromMicrosecondsSinceEpoch(data.time!.toInt()) : null);
}
