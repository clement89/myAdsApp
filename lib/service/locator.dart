import 'package:myads_app/service/app_service.dart';
import 'package:get_it/get_it.dart';

import 'api_manager.dart';

final locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<AppService>(() => AppService());
  locator.registerLazySingleton<ApiManager>(() => ApiManager());

}
