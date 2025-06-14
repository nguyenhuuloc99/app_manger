import 'dart:typed_data';

import 'package:app_manger/helper/helper.dart';

class AppInfo {
  String appName;
  Uint8List appIcon;
  String packageName;
  String version;
  String checkSum;
  String pathSdk;
  int uid;
  DateTime firstTimeInstall;
  DateTime lastTimeUpdate;

  AppInfo(
      {required this.appName,
      required this.appIcon,
      required this.packageName,
      required this.version,
      required this.checkSum,
      required this.pathSdk,
      required this.firstTimeInstall,
      required this.lastTimeUpdate, required this.uid});

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
        appName: json['appName'] as String,
        appIcon: dataFromBase64String(json['appIcon'] as String),
        packageName: json['packageName'] as String,
        version: json['version'] as String,
        checkSum: json['checkSum'] as String,
        pathSdk: json['pathSdk'] as String,
        uid: (json['uid'] as num).toInt(),
        firstTimeInstall: DateTime.fromMillisecondsSinceEpoch(
            (json['firstTimeInstall'] as num).toInt(), isUtc: true),
        lastTimeUpdate: DateTime.fromMillisecondsSinceEpoch(
            (json['lastTimeUpdate'] as num).toInt(), isUtc: true));
  }

  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appIcon': appIcon,
      'packageName': packageName,
      'version': version,
      'checkSum': checkSum,
      'pathSdk': pathSdk,
      'firstTimeInstall': firstTimeInstall,
      'lastTimeUpdate': lastTimeUpdate,
    };
  }
}
