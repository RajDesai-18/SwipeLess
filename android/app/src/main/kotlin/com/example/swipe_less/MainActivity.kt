//package com.example.swipe_less
//
//import android.app.usage.UsageStats
//import android.app.usage.UsageStatsManager
//import android.content.Context
//import android.os.Build
//import android.util.Log
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//import java.util.*
//
//class MainActivity : FlutterActivity() {
//    private val CHANNEL = "com.example.app_usage_tracker/usage"
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "getUsageStats") {
//                val appName = call.argument<String>("appName")
//                val usageTime = getAppUsageTime(appName)
//                result.success(usageTime)
//            }
//        }
//    }

//    private fun getAppUsageTime(appName: String?): Long {
//        if (appName == null) return 0L
//
//        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
//        val endTime = System.currentTimeMillis()
//        val startTime = endTime - (1000 * 60 * 60 * 24) // Last 24 hours
//
//        // Query usage stats
//        val usageStatsList = usageStatsManager.queryUsageStats(
//            UsageStatsManager.INTERVAL_DAILY,
//            startTime,
//            endTime
//        )
//
//        var totalTimeInForeground = 0L
//
//        // Iterate through the usage stats to find the app's usage time
//        for (usageStats in usageStatsList) {
//            if (usageStats.packageName == appName) {
//                totalTimeInForeground += usageStats.totalTimeInForeground
//            }
//            Log.d("UsageStats", "Package: ${usageStats.packageName}, Time: ${usageStats.totalTimeInForeground}")
//        }
//
//        return totalTimeInForeground // The time is in milliseconds
//    }
//}


package com.example.swipe_less

import android.app.usage.UsageStatsManager
import android.content.Context
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app_usage_tracker/usage"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getUsageStats") {
                val appName = call.argument<String>("appName")
                val usageTime = getAppUsageTime(appName)
                result.success(usageTime)
            }
        }
    }

    private fun getAppUsageTime(appName: String?): Long {
        if (appName == null) return 0L

        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val endTime = System.currentTimeMillis()
        val startTime = endTime - (1000 * 60 * 60 * 24) // Last 24 hours

        val usageStatsList = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            startTime,
            endTime
        )

        var totalTimeInForeground = 0L
        for (usageStats in usageStatsList) {
            if (usageStats.packageName == appName) {
                totalTimeInForeground += usageStats.totalTimeInForeground
            }
        }

        Log.d("UsageStats", "Total time for $appName: $totalTimeInForeground ms")
        return totalTimeInForeground
    }
}
