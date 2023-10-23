import 'package:flutter_modular/flutter_modular.dart';
import 'package:skywatch_application/data/repositories/weather_repository_impl.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';

import 'ui/home_page/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    // Repositories
    i.addLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        addressDrive: i.get<AddressDrive>(), httpDrive: i.get<HttpDrive>(), locationDrive: i.get<LocationDrive>()));
    // Use Case
    i.addLazySingleton<GetCurrentAddressUseCase>(() => GetCurrentAddressUseCase(i.get<WeatherRepository>()));
    i.addLazySingleton<GetCurrentLocationUseCase>(() => GetCurrentLocationUseCase(i.get<WeatherRepository>()));
    i.addLazySingleton<GetWeeklyForecastUseCase>(() => GetWeeklyForecastUseCase(i.get<WeatherRepository>()));
    // Bloc
    i.addLazySingleton<WeatherBloc>(() => WeatherBloc(
        i.get<GetCurrentLocationUseCase>(), i.get<GetCurrentAddressUseCase>(), i.get<GetWeeklyForecastUseCase>()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage(weatherBloc: Modular.get<WeatherBloc>()));
  }
}
