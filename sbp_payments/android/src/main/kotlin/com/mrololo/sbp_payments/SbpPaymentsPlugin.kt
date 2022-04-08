package com.mrololo.sbp_payments

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull


import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import payments.sbp.Callback

import payments.sbp.SbpUtils


/** SbpPaymentsPlugin */
class SbpPaymentsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context
    private var activity: Activity? = null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "github.com/MrOlolo/sbp_payments")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "showBanks") {
            if (activity != null) {
                SbpUtils.getInstance().showSbpListDialog(activity, call.argument<String>("url")) {
                    result.success(it);
                }
            } else {
                result.success(false)
            }
        } else if (call.method == "openWithBank") {
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = Uri.parse(call.argument<String>("url")!!)
            if (call.argument("scheme") as String? != null) {
                val packageName: String = call.argument("scheme")!!
                intent.setPackage(packageName)
                if (activity != null) {
                    try {
                        activity!!.startActivity(intent)
                        result.success(true)
                    } catch (e: ActivityNotFoundException) {
                        result.success(false)
                    }
                } else {
                    result.success(false)
                }
            } else {
                result.success(false)
            }


        } else if (call.method == "showBanksCustom") {
            if (activity != null) {
                SbpUtils.getInstance().showSbpListDialog(activity,
                        call.argument<String>("url"),
                        call.argument<Int>("text")!!,
                        call.argument<Int>("background")!!) {
                    result.success(it);
                }
            } else {
                result.success(false)
            }
        } else {
            result.notImplemented()

        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

}
