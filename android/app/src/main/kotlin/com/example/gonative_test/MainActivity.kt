package com.example.gonative_test

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

import gonativelib.DB

class MainActivity: FlutterActivity() {
  internal var db = DB()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, "example.com/gonative").setMethodCallHandler { methodCall, result ->
      if(methodCall.method == "db_opendb"){
        try {
            result.success(db.openDB())          
        }
        catch(e: Exception) {
          result.error("db_opendb", e.toString(), null)
        }
      }

       if(methodCall.method == "db_createDir"){
        try {
            result.success(db.createDir())          
        }
        catch(e: Exception) {
          result.error("db_createDir", e.toString(), null)
        }
      }

       if(methodCall.method == "db_existsDB"){
        try {
            result.success(db.existsDB())          
        }
        catch(e: Exception) {
          result.error("db_existsDB", e.toString(), null)
        }
      }

    }
  }
}
