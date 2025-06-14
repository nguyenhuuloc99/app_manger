package com.app.app_manger.model


data class AppInfoModel(
    val appName: String,
    val appIcon: String,
    val packageName: String,
    val version: String,
    val checkSum: String,
    val pathSdk: String,
    val uid: Int,
    val firstTimeInstall : Long,
    val lastTimeUpdate : Long
)