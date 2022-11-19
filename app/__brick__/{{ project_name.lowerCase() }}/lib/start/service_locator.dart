import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:vasile/app/app_messenger.dart';
import 'package:vasile/app/app_navigator.dart';
import 'package:vasile/app/cubit/app_cubit.dart';
import 'package:vasile/infrastructure/local_stores/app_info_store.dart';
import 'package:vasile/infrastructure/services/crash/crash_service.dart';
import 'package:vasile/infrastructure/services/fire_service.dart';
import 'package:vasile/infrastructure/services/log_service.dart';

GetIt getIt = GetIt.instance;

Future<void> registerInstances() async {
  final AppInfoStore appInfoStore = AppInfoStore();
  getIt.registerSingleton<AppInfoStore>(appInfoStore);
  await appInfoStore.init();

  final FireService fireService = FireService();
  getIt.registerSingleton(fireService);
  // We need to initialize Firebase here because the connectors constructors need this
  await fireService.init();
  final CrashService crashService = CrashService(appInfoStore);
  getIt.registerSingleton(crashService);
  final LogService logService = LogService(crashService);
  getIt.registerSingleton(logService);
  getIt.registerSingleton(RouteObserver());
  getIt.registerSingleton(AppMessenger());
  getIt.registerSingleton(AppNavigator());

  // Keep this at the end because it gets other dependencies injected into it
  getIt.registerSingleton(AppCubit());
}