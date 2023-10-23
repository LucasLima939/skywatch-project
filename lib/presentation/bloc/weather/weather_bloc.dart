import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch_application/domain/interfaces/use_cases/use_cases.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

import 'weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetCurrentAddressUseCase getCurrentAddressUseCase;
  final GetWeeklyForecastUseCase getWeeklyForecastUseCase;
  WeatherBloc(
    this.getCurrentLocationUseCase,
    this.getCurrentAddressUseCase,
    this.getWeeklyForecastUseCase,
  ) : super(const WeatherInitialState()) {
    on<GetCurrentLocationEvent>(_getCurrentLocation);
    on<GetCurrentAddressEvent>(_getCurrentAddress);
    on<GetWeeklyForecastEvent>(_getWeeklyForecast);
  }

  FutureOr<void> _getCurrentLocation(GetCurrentLocationEvent event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoadingState());

    final response = await getCurrentLocationUseCase(NoParams());

    response.fold((failure) => emit(WeatherFailureState(failure)), (response) => emit(WeatherLocationState(response)));
  }

  FutureOr<void> _getCurrentAddress(GetCurrentAddressEvent event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoadingState());

    final response = await getCurrentAddressUseCase(event.location);

    response.fold((failure) => emit(WeatherFailureState(failure)), (response) => emit(WeatherAddressState(response)));
  }


  FutureOr<void> _getWeeklyForecast(GetWeeklyForecastEvent event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoadingState());

    final response = await getWeeklyForecastUseCase(event.location);

    response.fold((failure) => emit(WeatherFailureState(failure)), (response) => emit(WeatherForecastState(response)));
  }
}
