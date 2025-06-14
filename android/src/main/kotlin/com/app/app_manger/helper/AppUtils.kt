package com.app.app_manger.helper

import com.app.app_manger.model.AppInfoModel

object AppUtils {
    fun AppInfoModel.toMap(): Map<String, Any> {
        return mapOf(
            "appName" to appName,
            "appIcon" to appIcon,
            "packageName" to packageName,
            "version" to version,
            "checkSum" to checkSum,
            "pathSdk" to pathSdk,
            "uid" to uid,
            "firstTimeInstall" to firstTimeInstall,
            "lastTimeUpdate" to lastTimeUpdate
        )
    }
}