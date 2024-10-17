package com.example.swipe_less

import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.swipe_less/usage"

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

        val usageEvents = usageStatsManager.queryEvents(startTime, endTime)
        var totalTimeInForeground = 0L
        var lastEventTime = 0L
        var isAppInForeground = false

        while (usageEvents.hasNextEvent()) {
            val event = UsageEvents.Event()
            usageEvents.getNextEvent(event)

            if (event.packageName == appName) {
                when (event.eventType) {
                    UsageEvents.Event.MOVE_TO_FOREGROUND -> {
                        lastEventTime = event.timeStamp
                        isAppInForeground = true
                    }
                    UsageEvents.Event.MOVE_TO_BACKGROUND -> {
                        if (isAppInForeground) {
                            totalTimeInForeground += event.timeStamp - lastEventTime
                            isAppInForeground = false
                        }
                    }
                }
            }
        }

        // Log the total time spent in the foreground for debugging
        Log.d("UsageStats", "Total time in foreground for $appName: $totalTimeInForeground ms")
        return totalTimeInForeground
    }
}
