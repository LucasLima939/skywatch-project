import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class ForecastEntity extends Equatable {
  final List<WeatherEntity> entities;
  const ForecastEntity({required this.entities,});

  @override
  List<Object> get props => [entities];
}