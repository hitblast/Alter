// First-party imports.
import 'package:flutter/services.dart';

/// The LoginItemsService class provides a MethodChannel-based wrapper
/// for managing login item entry for the project on a Mac.
class LoginItemsService {
  static const MethodChannel _channel = MethodChannel(
    'com.hitblast.alter/login',
  );

  /// Registers the login item entry.
  static Future<bool> enableLaunchAtLogin() async {
    try {
      final bool result = await _channel.invokeMethod('enableLaunchAtLogin');
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to enable launch at login: ${e.message}';
    }
  }

  /// Unregisters the login item entry.
  static Future<bool> disableLaunchAtLogin() async {
    try {
      final bool result = await _channel.invokeMethod('disableLaunchAtLogin');
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to disable launch at login: ${e.message}';
    }
  }

  /// Checks if the login item entry is registered.
  static Future<bool> isLaunchAtLoginEnabled() async {
    try {
      final bool result = await _channel.invokeMethod('isLaunchAtLoginEnabled');
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to retrieve launch at login status: ${e.message}';
    }
  }
}
