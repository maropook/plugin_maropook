package com.example.plugin_maropook

import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.ExperimentalCoroutinesApi

class MainActivity: FlutterActivity() {
    private val CHANNEL = "appInfo"

    @OptIn(ExperimentalCoroutinesApi::class)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
                call, result ->
     if(call.method == "getAppVersion"){
                try {
                    val pInfo = applicationContext.packageManager.getPackageInfo(context.packageName, 0)
                    var version = pInfo.versionName
                    result.success("${pInfo.versionName}");

                } catch (e: PackageManager.NameNotFoundException) {
                   e.printStackTrace()
                    result.notImplemented()
                }
            }else{
                result.notImplemented()
            }
        }
    }
}
