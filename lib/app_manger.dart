import 'package:app_manger/model/app_info.dart';

import 'app_manger_platform_interface.dart';

class AppManger {
  Future<List<AppInfo>> getListAppInstall() {
    return AppMangerPlatform.instance.getListAppInstall();
  }

  Future<AppInfo?> getAppInfo(String packageName) async {
    return AppMangerPlatform.instance.appInfo(packageName);
  }

  Future startLaunchApp(String packageName) async{
    return  AppMangerPlatform.instance.startLaunchApp(packageName);
  }
}
