package com.thirteenmonths.thirteen_months

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class IfcWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val options = appWidgetManager.getAppWidgetOptions(widgetId)
            val views = buildViews(context, options, widgetData)
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        val widgetData = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val views = buildViews(context, newOptions, widgetData)
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }

    private fun buildViews(
        context: Context,
        options: Bundle,
        widgetData: SharedPreferences
    ): RemoteViews {
        val minWidth = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH, 0)
        val minHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 0)

        val dateText = widgetData.getString("ifc_date_text", "IFC Date") ?: "IFC Date"
        val gregorianText = widgetData.getString("gregorian_date_text", "") ?: ""

        return when {
            // Large: wide enough and tall enough for analog clock
            minWidth >= 200 && minHeight >= 100 -> {
                RemoteViews(context.packageName, R.layout.ifc_widget_large).apply {
                    setTextViewText(R.id.ifc_date_text, dateText)
                    setTextViewText(R.id.gregorian_date_text, gregorianText)
                }
            }
            // Medium: wide but not tall — centered time + date
            minWidth >= 200 -> {
                RemoteViews(context.packageName, R.layout.ifc_widget_medium).apply {
                    setTextViewText(R.id.ifc_date_text, dateText)
                }
            }
            // Small: time + small IFC date
            else -> {
                RemoteViews(context.packageName, R.layout.ifc_widget_small).apply {
                    setTextViewText(R.id.ifc_date_text, dateText)
                }
            }
        }
    }
}
