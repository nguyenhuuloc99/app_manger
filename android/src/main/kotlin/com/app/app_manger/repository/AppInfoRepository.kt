package com.app.app_manger.repository

import android.content.Context
import com.app.app_manger.helper.HashUtils
import com.app.app_manger.helper.StringUtils
import com.app.app_manger.model.AppInfoModel
import java.security.MessageDigest

class AppInfoRepository(private val context: Context) {

    fun getAppInfoByPackageName(packageName: String): AppInfoModel {
        val packageManager = context.packageManager
        val applicationInfo = packageManager.getApplicationInfo(packageName, 0)
        val appName = packageManager.getApplicationLabel(applicationInfo).toString()
        val packageInfo = packageManager.getPackageInfo(packageName, 0)
        val versionName = packageInfo.versionName
        val appIcon =
            StringUtils.drawableToBase64(applicationInfo.loadIcon(packageManager))
        val apkFilePath = packageInfo.applicationInfo.sourceDir
        val checkSum = HashUtils.getCheckSumFromFile(
            digest = MessageDigest.getInstance("SHA-256"),
            filePath = apkFilePath
        )
        val firstTimeInstall = packageInfo.firstInstallTime
        val lastTimeUpdate = packageInfo.lastUpdateTime
        val uid = applicationInfo.uid

        return AppInfoModel(
            appName = appName,
            appIcon = appIcon,
            packageName = packageInfo.packageName,
            version = versionName,
            checkSum = checkSum,
            pathSdk = apkFilePath,
            uid = uid,
            firstTimeInstall = firstTimeInstall,
            lastTimeUpdate = lastTimeUpdate
        )
    }
}