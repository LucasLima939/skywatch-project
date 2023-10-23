import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentAddressEvent extends WeatherEvent {
  final LocationEntity location;
  const GetCurrentAddressEvent(this.location); 

  @override
  List<Object?> get props => [location];
}

class GetCurrentLocationEvent extends WeatherEvent {
  const GetCurrentLocationEvent(); 
}

class GetWeeklyForecastEvent extends WeatherEvent {
  final LocationEntity location;
  const GetWeeklyForecastEvent(this.location); 

  @override
  List<Object?> get props => [location];
}