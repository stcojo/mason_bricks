import 'package:flutter/services.dart';
import 'package:vasile/infrastructure/services/crash/crash_service.dart';
import 'package:vasile/infrastructure/services/log_service.dart';

import 'service_locator.dart';

Future<void> init() async {
  final CrashService crashService = getIt<CrashService>();
  final LogService logService = getIt<LogService>();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  await logService.init();
  await crashService.init();
}
