import 'package:app_manger/model/app_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_manger_method_channel.dart';

abstract class AppMangerPlatform extends PlatformInterface {
  /// Constructs a AppMangerPlatform.
  AppMangerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppMangerPlatform _instance = MethodChannelAppManger();

  /// The default instance of [AppMangerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppManger].
  static AppMangerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppMangerPlatform] when
  /// they register themselves.
  static set instance(AppMangerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<AppInfo>> getListAppInstall() {
    throw UnimplementedError("listAppInstall() has not been implemented");
  }

  Future<AppInfo?> appInfo(String packageName) {
    throw UnimplementedError("appInfo() has not been implemented");
  }

  Future startLaunchApp(String packageName) {
    throw UnimplementedError("startLaunchApp() has not been implemented");
  }
}
