package com.app.app_manger.repository

import android.content.Context
import android.content.Intent
import com.app.app_manger.helper.HashUtils
import com.app.app_manger.helper.StringUtils
import com.app.app_manger.model.AppInfoModel
import java.security.MessageDigest

class AppListRepository constructor(private val context: Context) {

    fun getAppList(): List<AppInfoModel> {
        val listOfApps = mutableListOf<AppInfoModel>()

        val mainIntent = Intent(Intent.ACTION_MAIN, null)

        mainIntent.addCategory(Intent.CATEGORY_LAUNCHER)

        val packageManager = context.packageManager

        val queryIntentActivity = packageManager.queryIntentActivities(mainIntent, 0)

        for (app in queryIntentActivity) {
            app.activityInfo?.let {
                val res =
                    packageManager.getResourcesForApplication(app.activityInfo.applicationInfo)

                val appName = if (app.activityInfo.labelRes != 0) {
                    res.getString(app.activityInfo.labelRes)
                } else {
                    app.activityInfo.applicationInfo.loadLabel(packageManager).toString()
                }
                val packageName = app.activityInfo.applicationInfo.packageName.toString()
                val applicationInfo = packageManager.getApplicationInfo(packageName, 0)
                val packageInfo = packageManager.getPackageInfo(packageName, 0)
                val versionName = packageInfo.versionName

                val appIcon = StringUtils.drawableToBase64(applicationInfo.loadIcon(packageManager))
                val apkFilePath = packageInfo.applicationInfo.sourceDir
                val firstTimeInstall = packageInfo.firstInstallTime
                val lastTimeUpdate = packageInfo.lastUpdateTime
                val checkSum = HashUtils.getCheckSumFromFile(
                    digest = MessageDigest.getInstance("SHA-256"),
                    filePath = apkFilePath
                )
                val uid = app.activityInfo.applicationInfo.uid

                listOfApps.add(
                    AppInfoModel(
                        appName = appName,
                        appIcon = appIcon,
                        packageName = packageName,
                        version = versionName,
                        checkSum = checkSum,
                        pathSdk = apkFilePath,
                        uid = uid,
                        firstTimeInstall = firstTimeInstall,
                        lastTimeUpdate = lastTimeUpdate
                    )
                )
            }
        }

        return listOfApps;
    }
}