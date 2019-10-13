package com.example.gonative_test

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

import gonativelib.Server

class MainActivity: FlutterActivity() {
  internal var server = Server()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, "example.com/gonative").setMethodCallHandler { methodCall, result ->
      if(methodCall.method == "Server_run"){
        try {
            result.success(server.run())
          result.error("data = null", "",null)
          
        }
        catch(e: Exception) {
          result.error("Server_run", e.toString(), null)
        }
      }

    }
  }
}
