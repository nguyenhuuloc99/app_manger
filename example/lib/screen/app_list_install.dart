import 'package:app_manger/app_manger.dart';
import 'package:app_manger/model/app_info.dart';
import 'package:app_manger_example/screen/app_info_detail.dart';
import 'package:flutter/material.dart';

class AppListInstall extends StatefulWidget {
  const AppListInstall({super.key});

  @override
  State<AppListInstall> createState() => _AppListInstallState();
}

class _AppListInstallState extends State<AppListInstall> {
  final _appMangerPlugin = AppManger();
  List<AppInfo> listAppInfo = [];

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    var response = await _appMangerPlugin.getListAppInstall();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      listAppInfo = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App List"),
      ),
      body: SafeArea(
        child: Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppInfoDetail(
                          packageName: listAppInfo[index].packageName)));
                },
                title: Text(listAppInfo[index].appName),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.memory(listAppInfo[index].appIcon),
                ),
                subtitle: Text(
                  listAppInfo[index].pathSdk,
                  maxLines: 1,
                ),
              );
            },
            itemCount: listAppInfo.length,
          ),
        ),
      ),
    );
  }
}
