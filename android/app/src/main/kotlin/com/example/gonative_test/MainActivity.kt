package com.example.gonative_test

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

import gonativelib.DataProcessor

class MainActivity: FlutterActivity() {
  internal var goNativeDataProcessor = DataProcessor()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, "example.com/gonative").setMethodCallHandler { methodCall, result ->
      if(methodCall.method == "dataProcessor_increment"){
        try {
          val data = methodCall.argument<Int>("data")
          if(data != null) {
            result.success(goNativeDataProcessor.increment(data.toLong()))
          }
          result.error("data = null", "",null)
          
        }
        catch(e: Exception) {
          result.error("dataProcessor_increment", e.toString(), null)
        }
      }

    }
  }
}
