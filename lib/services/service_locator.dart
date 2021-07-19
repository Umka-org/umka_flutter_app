import 'package:get_it/get_it.dart';
import 'package:umka_flutter/services/umka_service.dart';

final serviceLocator = GetIt.instance;

Future initServiceLocator() async {
  serviceLocator.resetLazySingleton<UmkaService>();
}

get umkaService => serviceLocator<UmkaService>();
