import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HiDefend {
  run(Widget app) {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.empty);
      } else {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    runZonedGuarded(() {
      runApp(app);
    }, (e, s) {
      _reportError(e, s);
    });
  }

  void _reportError(Object e, StackTrace s) {
    print("HiDefend($kReleaseMode):error:$e,$s");
  }
}
