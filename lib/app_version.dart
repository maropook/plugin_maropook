import 'package:flutter/services.dart';

class Native {
  static const MethodChannel _channel = MethodChannel('hello');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getAppVersion2');
    return version;
  }
}
