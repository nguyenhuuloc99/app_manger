import 'package:app_manger/model/app_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_manger_platform_interface.dart';

/// An implementation of [AppMangerPlatform] that uses method channels.
class MethodChannelAppManger extends AppMangerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_manger');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<AppInfo>> getListAppInstall() async {
    final listAppInstall =
        await methodChannel.invokeListMethod<dynamic>('getListApp');

    if (listAppInstall == null) return [];

    return listAppInstall
        .map((e) => AppInfo.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<AppInfo?> appInfo(String packageName) async {
    final data = await methodChannel.invokeMapMethod<String, dynamic>(
        'getAppInfo', {"package_name": packageName});
    if (data == null) return null;

    return AppInfo.fromJson(data);
  }
  
  @override
  Future startLaunchApp(String packageName) async{
    methodChannel.invokeMethod("launchApp", {"package_name" : packageName});
  }
}
