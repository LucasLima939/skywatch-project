import 'package:location/location.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.altitude,
    required super.latitude,
    required super.longitude,
    required super.time,
  });
  const LocationModel.empty() : super(altitude: 0.0, latitude: 0.0, longitude: 0.0, time: null);
  LocationModel.fromLocationData(LocationData data)
      : super(
            altitude: data.altitude,
            latitude: data.latitude,
            longitude: data.longitude,
            time: data.time != null ? DateTime.fromMicrosecondsSinceEpoch(data.time!.toInt()) : null);
}
