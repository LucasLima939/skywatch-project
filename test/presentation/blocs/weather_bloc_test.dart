import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/failures.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';
import 'package:bloc_test/bloc_test.dart';

import '../mocks/mocks.dart';

void main() {
  late WeatherBloc sut;
  late GetCurrentAddressUseCaseMock getCurrentAddressUseCaseMock;
  late GetCurrentLocationUseCaseMock getCurrentLocationUseCaseMock;
  late GetWeeklyForecastUseCaseMock getWeeklyForecastUseCaseMock;
  late LocationEntity locationResponse;
  late AddressEntity addressResponse;
  late ForecastEntity forecastEntity;

  final failure = GenericFailure(Exception());

  setUp(() {
    getCurrentAddressUseCaseMock = GetCurrentAddressUseCaseMock();
    getCurrentLocationUseCaseMock = GetCurrentLocationUseCaseMock();
    getWeeklyForecastUseCaseMock = GetWeeklyForecastUseCaseMock();
    sut = WeatherBloc(
      getCurrentLocationUseCaseMock,
      getCurrentAddressUseCaseMock,
      getWeeklyForecastUseCaseMock,
    );
    locationResponse = LocationModel.empty();
    addressResponse = const AddressModel.empty();
    forecastEntity = ForecastModel.empty();
    getCurrentAddressUseCaseMock.mockCall(locationResponse, addressResponse);
    getCurrentLocationUseCaseMock.mockCall(locationResponse);
    getWeeklyForecastUseCaseMock.mockCall(locationResponse, forecastEntity);
  });
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  group('Get Current Location', () {
    blocTest<WeatherBloc, WeatherState>(
      'Emits entity if was no error',
      build: () => sut,
      act: (WeatherBloc bloc) => bloc.add(const GetCurrentLocationEvent()),
      expect: () => [
        const WeatherLoadingState(),
        WeatherLocationState(locationResponse),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'Emits failure if has some error',
      build: () {
        getCurrentLocationUseCaseMock.mockCallError(failure);
        return sut;
      },
      act: (WeatherBloc bloc) => bloc.add(const GetCurrentLocationEvent()),
      expect: () => [
        const WeatherLoadingState(),
        WeatherFailureState(failure),
      ],
    );
  });

  group('Get Current Address', () {
    blocTest<WeatherBloc, WeatherState>(
      'Emits entity if was no error',
      build: () {
        getCurrentAddressUseCaseMock.mockCall(locationResponse, addressResponse);
        return sut;
      },
      act: (WeatherBloc bloc) => bloc.add(GetCurrentAddressEvent(locationResponse)),
      expect: () => [
        const WeatherLoadingState(),
        WeatherAddressState(addressResponse),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'Emits failure if has some error',
      build: () {
        getCurrentAddressUseCaseMock.mockCallError(locationResponse, failure);
        return sut;
      },
      act: (WeatherBloc bloc) => bloc.add(GetCurrentAddressEvent(locationResponse)),
      expect: () => [
        const WeatherLoadingState(),
        WeatherFailureState(failure),
      ],
    );
  });

  group('Get Current Address', () {
    blocTest<WeatherBloc, WeatherState>(
      'Emits entity if was no error',
      build: () {
        getWeeklyForecastUseCaseMock.mockCall(locationResponse, forecastEntity);
        return sut;
      },
      act: (WeatherBloc bloc) => bloc.add(GetWeeklyForecastEvent(locationResponse)),
      expect: () => [
        const WeatherLoadingState(),
        WeatherForecastState(forecastEntity),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'Emits failure if has some error',
      build: () {
        getWeeklyForecastUseCaseMock.mockCallError(locationResponse, failure);
        return sut;
      },
      act: (WeatherBloc bloc) => bloc.add(GetWeeklyForecastEvent(locationResponse)),
      expect: () => [
        const WeatherLoadingState(),
        WeatherFailureState(failure),
      ],
    );
  });
}
