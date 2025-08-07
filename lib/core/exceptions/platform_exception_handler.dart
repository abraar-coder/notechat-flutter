import 'package:flutter/services.dart';
import 'app_exception.dart';

class PlatformExceptionHandler {
  static AppException handle(PlatformException e) {
    return AppException('Platform Error: ${e.message ?? "Unknown"}');
  }
}
