import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class WeatherAddressState extends WeatherState {
  final AddressEntity entity;
  const WeatherAddressState(this.entity);

  @override
  List<Object?> get props => [entity];
}

class WeatherLocationState extends WeatherState {
  final LocationEntity entity;
  const WeatherLocationState(this.entity);

  @override
  List<Object?> get props => [entity];
}

class WeatherForecastState extends WeatherState {
  final ForecastEntity entity;
  const WeatherForecastState(this.entity);

  @override
  List<Object?> get props => [entity];
}

class WeatherFailureState extends WeatherState {
  final Failure failure;
  final dynamic refreshEvent;
  const WeatherFailureState(this.failure, [this.refreshEvent]);

  @override
  List<Object?> get props => [failure, refreshEvent];
}