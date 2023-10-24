import 'package:flutter_modular/flutter_modular.dart';
import 'package:skywatch_application/data/adapters/adapters.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(i) {
    // Adapters
    i.addLazySingleton<HttpDrive>(() => HttpAdapter());
    i.addLazySingleton<LocationDrive>(() => LocationAdapter());
  }
}
