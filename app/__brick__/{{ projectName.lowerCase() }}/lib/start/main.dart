import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:{{ projectName.snakeCase() }}/app/app.dart';
import 'package:{{ projectName.snakeCase() }}/services/generic/crash/crash_service.dart';
import 'package:flutter/material.dart';

import 'main_utils.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await registerInstances();
  await init();

  const Widget app = MainApp();
  if (kReleaseMode) {
    runAppInReleaseMode(app);
  } else {
    runApp(app);
  }
  FlutterNativeSplash.remove();
}

void runAppInReleaseMode(Widget app) {
  runZonedGuarded<Future<void>>(() async {
    runApp(app);
  }, (Object error, StackTrace stack) async {
    await getIt<CrashService>().handleAppError(error, stack);
  });
}
