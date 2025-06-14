package com.app.app_manger

import android.content.Context
import android.content.Intent
import com.app.app_manger.helper.AppUtils.toMap
import com.app.app_manger.repository.AppInfoRepository
import com.app.app_manger.repository.AppListRepository
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AppMangerPlugin */
class AppMangerPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        mContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "app_manger")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getListApp" -> {
                try {
                    val appListInfo = AppListRepository(mContext)
                    val listAppInfoModel = appListInfo.getAppList()
                    val list = listAppInfoModel.map { it.toMap() }
                    result.success(list)
                } catch (e: Exception) {
                    result.error("GET_LIST_ERROR", "Failed to get app list", e.message)
                }
            }

            "getAppInfo" -> {
                try {
                    val packageName: String? = call.argument("package_name")
                    if (packageName == null) {
                        result.error("INVALID_ARGUMENT", "package_name is null", null)
                        return
                    }
                    val appInfoRepository = AppInfoRepository(mContext)
                    val appInfo = appInfoRepository.getAppInfoByPackageName(packageName)
                    result.success(appInfo?.toMap())
                } catch (e: Exception) {
                    result.error("GET_INFO_ERROR", "Failed to get app info", e.message)
                }
            }

            "launchApp" -> {
                try {
                    val packageName: String? = call.argument("package_name")
                    if (packageName.isNullOrEmpty()) {
                        result.error("INVALID_ARGUMENT", "package_name is null or empty", null)
                        return
                    }

                    val launchIntent = mContext.packageManager.getLaunchIntentForPackage(packageName)
                    if (launchIntent != null) {
                        launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        mContext.startActivity(launchIntent)
                        result.success(true)
                    } else {
                        result.error("LAUNCH_ERROR", "App not found or not launchable", null)
                    }
                } catch (e: Exception) {
                    result.error("LAUNCH_ERROR", "Failed to launch app", e.message)
                }
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
