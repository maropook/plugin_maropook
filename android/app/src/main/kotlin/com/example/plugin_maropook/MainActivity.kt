package com.example.plugin_maropook

import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.ExperimentalCoroutinesApi

class MainActivity: FlutterActivity() {
    private val CHANNEL = "hello"

    @OptIn(ExperimentalCoroutinesApi::class)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
                call, result ->

            if(call.method =="changeColor" ){
                changeColor(call, result)
            }else if(call.method == "getAppVersion2"){
                var version = ""
                try {
                    val pInfo = applicationContext.packageManager.getPackageInfo(context.packageName, 0)
                    version = pInfo.versionName
                    result.success("${version}");


                } catch (e: PackageManager.NameNotFoundException) {
                   e.printStackTrace()

                }

            }else{
                result.notImplemented()
            }

        }
    }
    private fun changeColor(call: MethodCall, result: MethodChannel.Result) {
        var color = call.argument<String>("color");
        result.success(color);
    }
}
