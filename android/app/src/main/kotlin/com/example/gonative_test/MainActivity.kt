package com.example.gonative_test

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

import gonativelib.StorageTest

class MainActivity: FlutterActivity() {
  internal var storageTest = StorageTest()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, "example.com/gonative").setMethodCallHandler { methodCall, result ->
      if(methodCall.method == "storageTest_write"){
        try {
          val msg = methodCall.argument<String>("msg")
          if(msg != null) {
            result.success(storageTest.write(msg))
          }
          result.error("msg = null", "",null)
          
        }
        catch(e: Exception) {
          result.error("storageTest_write", e.toString(), null)
        }
      }

      if(methodCall.method == "storageTest_getcwd"){
        try {
          result.success(storageTest.getCwd())          
        }
        catch(e: Exception) {
          result.error("storageTest_getCwd", e.toString(), null)
        }
      }

      if(methodCall.method == "storageTest_listFiles"){
        try {
          result.success(storageTest.listFiles())          
        }
        catch(e: Exception) {
          result.error("storageTest_listFiles", e.toString(), null)
        }
      }

      if(methodCall.method == "storageTest_read"){
        try {
          result.success(storageTest.read())          
        }
        catch(e: Exception) {
          result.error("storageTest_read", e.toString(), null)
        }
      }
    }

    
  }
}
