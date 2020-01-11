package com.example.baixing

import androidx.annotation.NonNull
import com.example.plugin.asr.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        registerSelfPlugin() // 注册插件
    }

    // 声明插件函数
    private fun registerSelfPlugin(){
//        AsrPlugin.registerWith(registrarFor("com.example.plugin.asr"))
    }
}
