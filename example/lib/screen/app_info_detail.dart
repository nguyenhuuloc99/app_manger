import 'package:app_manger/app_manger.dart';
import 'package:app_manger/model/app_info.dart';
import 'package:flutter/material.dart';

class AppInfoDetail extends StatefulWidget {
  final String packageName;

  const AppInfoDetail({super.key, required this.packageName});

  @override
  State<AppInfoDetail> createState() => _AppInfoDetailState();
}

class _AppInfoDetailState extends State<AppInfoDetail> {
  final _appManager = AppManger();
  AppInfo? appInfo;

  @override
  void initState() {
    getInfoApp(widget.packageName);
    super.initState();
  }

  void getInfoApp(String packageName) async {
    var data = await _appManager.getAppInfo(packageName);
    setState(() {
      appInfo = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Info"),
      ),
      body: appInfo == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.memory(appInfo!.appIcon),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("App Name : ${appInfo?.appName}"),
                    const SizedBox(height: 10),
                    Text("Package Name : ${appInfo?.packageName}"),
                    const SizedBox(height: 10),
                    Text("Version : ${appInfo?.version}"),
                    const SizedBox(height: 10),
                    Text("Check Sum : ${appInfo?.checkSum}"),
                    const SizedBox(height: 10),
                    Text("UID : ${appInfo?.uid}"),
                    const SizedBox(height: 10),
                    Text("Path Sdk ${appInfo?.pathSdk}"),
                    const SizedBox(height: 10),
                    Text("First Time Install : ${appInfo?.firstTimeInstall}"),
                    const SizedBox(height: 10),
                    Text("Last Time Update :${appInfo?.lastTimeUpdate}"),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _appManager.startLaunchApp(appInfo!.packageName);
                        },
                        child: const Text("Open App"),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
