
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skywatch_application/core_module.dart';
import 'package:skywatch_application/presentation/home_module.dart';

class AppModule extends Module {
  AppModule();

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
  }
}