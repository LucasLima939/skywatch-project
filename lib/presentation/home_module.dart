import 'package:flutter_modular/flutter_modular.dart';
import 'package:skywatch_application/data/repositories/repositories.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';
import 'package:skywatch_application/presentation/bloc/videos/videos.dart';
import 'package:skywatch_application/presentation/bloc/weather/weather.dart';

import 'ui/home/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    // Repositories
    i.addLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(httpDrive: i.get<HttpDrive>(), locationDrive: i.get<LocationDrive>()));
    i.addLazySingleton<VideosRepository>(
        () => VideosRepositoryImpl(filePickerDrive: i.get<FilePickerDrive>(), firebaseDrive: i.get<FirebaseDrive>()));
    // Weather Use Cases
    i.addLazySingleton<GetCurrentAddressUseCase>(() => GetCurrentAddressUseCase(i.get<WeatherRepository>()));
    i.addLazySingleton<GetCurrentLocationUseCase>(() => GetCurrentLocationUseCase(i.get<WeatherRepository>()));
    i.addLazySingleton<GetWeeklyForecastUseCase>(() => GetWeeklyForecastUseCase(i.get<WeatherRepository>()));
    // Videos Use Cases
    i.addLazySingleton<GetVideoResponseUseCase>(() => GetVideoResponseUseCase(i.get<VideosRepository>()));
    i.addLazySingleton<GetVideoUseCase>(() => GetVideoUseCase(i.get<VideosRepository>()));
    i.addLazySingleton<LikeVideoUseCase>(() => LikeVideoUseCase(i.get<VideosRepository>()));
    i.addLazySingleton<RemoveLikeVideoUseCase>(() => RemoveLikeVideoUseCase(i.get<VideosRepository>()));
    i.addLazySingleton<UploadVideoUseCase>(() => UploadVideoUseCase(i.get<VideosRepository>()));
    i.addLazySingleton<WriteEntityUseCase>(() => WriteEntityUseCase(i.get<VideosRepository>()));
    // Bloc
    i.addLazySingleton<WeatherBloc>(() => WeatherBloc(
          i.get<GetCurrentLocationUseCase>(),
          i.get<GetCurrentAddressUseCase>(),
          i.get<GetWeeklyForecastUseCase>(),
        ));
    i.addLazySingleton<VideosBloc>(() => VideosBloc(
          i.get<GetVideoResponseUseCase>(),
          i.get<GetVideoUseCase>(),
          i.get<LikeVideoUseCase>(),
          i.get<RemoveLikeVideoUseCase>(),
          i.get<UploadVideoUseCase>(),
          i.get<WriteEntityUseCase>(),
        ));
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => HomePage(
              weatherBloc: Modular.get<WeatherBloc>(),
              videosBloc: Modular.get<VideosBloc>(),
            ));
  }
}
