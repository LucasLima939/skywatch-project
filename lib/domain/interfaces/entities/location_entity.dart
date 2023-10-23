import 'package:equatable/equatable.dart';

abstract class LocationEntity extends Equatable {
  final double latitude;
  final double longitude;
  final double altitude;
  final DateTime? time;
  const LocationEntity({
    required this.altitude,
    required this.latitude,
    required this.longitude,
    required this.time,
  });

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    altitude,
    time,
  ];
}
