import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'log.dart';
import 'smart_management.dart';

/// GetInterface allows any auxiliary package to be merged into the "Get"
/// class through extensions
abstract class GetInterface {
  SmartManagement smartManagement = SmartManagement.full;
  RouterDelegate? routerDelegate;
  RouteInformationParser? routeInformationParser;
  LogWriterCallback log = defaultLogWriterCallback;
}

class GetConst {
  GetConst._();
  static bool isLogEnable = kDebugMode;
}
