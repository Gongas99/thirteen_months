package com.thirteenmonths.thirteen_months

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.SizeF
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
            updateWidget(context, appWidgetManager, widgetId, options, widgetData)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        val widgetData = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        updateWidget(context, appWidgetManager, appWidgetId, newOptions, widgetData)
    }

    private fun updateWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        options: Bundle,
        widgetData: SharedPreferences
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val viewMapping = buildResponsiveLayouts(context, widgetData)
            appWidgetManager.updateAppWidget(appWidgetId, RemoteViews(viewMapping))
        } else {
            val views = buildViews(context, options, widgetData)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun buildResponsiveLayouts(
        context: Context,
        widgetData: SharedPreferences
    ): Map<SizeF, RemoteViews> {
        val dateText = widgetData.getString("ifc_date_text", "IFC Date") ?: "IFC Date"
        val gregorianText = widgetData.getString("gregorian_date_text", "") ?: ""
        val isTransparent = widgetData.getBoolean("widget_transparent", true)

        return mapOf(
            // 1x1 — date only
            SizeF(57f, 25f) to createDateOnlyViews(context, dateText, isTransparent),
            // 2x1 — small clock + date
            SizeF(130f, 25f) to createSmallViews(context, dateText, isTransparent),
            // 3x1 or wider but short — wide horizontal layout
            SizeF(250f, 25f) to createWideViews(context, dateText, gregorianText, isTransparent),
            // 2x2 — medium vertical
            SizeF(130f, 100f) to createMediumViews(context, dateText, isTransparent),
            // 3x2+ — large with all details
            SizeF(250f, 100f) to createLargeViews(context, dateText, gregorianText, isTransparent),
        )
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
        val isTransparent = widgetData.getBoolean("widget_transparent", true)

        return when {
            // Wide horizontal strip (3+ cells wide, 1 cell tall)
            minWidth >= 250 && minHeight < 100 ->
                createWideViews(context, dateText, gregorianText, isTransparent)
            // Large (2+ cells wide, 2+ cells tall)
            minWidth >= 200 && minHeight >= 100 ->
                createLargeViews(context, dateText, gregorianText, isTransparent)
            // Medium (2+ cells wide)
            minWidth >= 130 ->
                createMediumViews(context, dateText, isTransparent)
            // Small with clock (enough width for time)
            minWidth >= 90 ->
                createSmallViews(context, dateText, isTransparent)
            // Very small — date only
            else ->
                createDateOnlyViews(context, dateText, isTransparent)
        }
    }

    private fun createDateOnlyViews(
        context: Context,
        dateText: String,
        isTransparent: Boolean
    ): RemoteViews {
        return RemoteViews(context.packageName, R.layout.ifc_widget_date_only).apply {
            setTextViewText(R.id.ifc_date_text, dateText)
            applyBackground(this, isTransparent)
            applyClickToOpen(context, this)
            if (!isTransparent) {
                setTextColor(R.id.ifc_date_text, COLOR_SECONDARY)
            }
        }
    }

    private fun createSmallViews(
        context: Context,
        dateText: String,
        isTransparent: Boolean
    ): RemoteViews {
        return RemoteViews(context.packageName, R.layout.ifc_widget_small).apply {
            setTextViewText(R.id.ifc_date_text, dateText)
            applyBackground(this, isTransparent)
            applyClickToOpen(context, this)
            if (!isTransparent) {
                setTextColor(R.id.widget_text_clock, COLOR_PRIMARY)
                setTextColor(R.id.ifc_date_text, COLOR_SECONDARY)
            }
        }
    }

    private fun createMediumViews(
        context: Context,
        dateText: String,
        isTransparent: Boolean
    ): RemoteViews {
        return RemoteViews(context.packageName, R.layout.ifc_widget_medium).apply {
            setTextViewText(R.id.ifc_date_text, dateText)
            applyBackground(this, isTransparent)
            applyClickToOpen(context, this)
            if (!isTransparent) {
                setTextColor(R.id.widget_text_clock, COLOR_PRIMARY)
                setTextColor(R.id.ifc_date_text, COLOR_SECONDARY)
            }
        }
    }

    private fun createWideViews(
        context: Context,
        dateText: String,
        gregorianText: String,
        isTransparent: Boolean
    ): RemoteViews {
        return RemoteViews(context.packageName, R.layout.ifc_widget_wide).apply {
            setTextViewText(R.id.ifc_date_text, dateText)
            setTextViewText(R.id.gregorian_date_text, gregorianText)
            applyBackground(this, isTransparent)
            applyClickToOpen(context, this)
            if (!isTransparent) {
                setTextColor(R.id.widget_text_clock, COLOR_PRIMARY)
                setTextColor(R.id.ifc_date_text, COLOR_SECONDARY)
                setTextColor(R.id.gregorian_date_text, COLOR_SECONDARY)
            }
        }
    }

    private fun createLargeViews(
        context: Context,
        dateText: String,
        gregorianText: String,
        isTransparent: Boolean
    ): RemoteViews {
        return RemoteViews(context.packageName, R.layout.ifc_widget_large).apply {
            setTextViewText(R.id.ifc_date_text, dateText)
            setTextViewText(R.id.gregorian_date_text, gregorianText)
            applyBackground(this, isTransparent)
            applyClickToOpen(context, this)
            if (!isTransparent) {
                setTextColor(R.id.widget_text_clock, COLOR_PRIMARY)
                setTextColor(R.id.ifc_date_text, COLOR_SECONDARY)
                setTextColor(R.id.gregorian_date_text, COLOR_SECONDARY)
                setTextColor(R.id.ifc_label, COLOR_TERTIARY)
                setTextColor(R.id.gregorian_label, COLOR_TERTIARY)
            }
        }
    }

    companion object {
        private val COLOR_PRIMARY = Color.parseColor("#FFFFFFFF")
        private val COLOR_SECONDARY = Color.parseColor("#B3FFFFFF")
        private val COLOR_TERTIARY = Color.parseColor("#80FFFFFF")
    }

    private fun applyBackground(views: RemoteViews, isTransparent: Boolean) {
        if (isTransparent) {
            views.setInt(R.id.widget_root, "setBackgroundColor", Color.TRANSPARENT)
        } else {
            views.setInt(R.id.widget_root, "setBackgroundResource", R.drawable.widget_bg_opaque)
        }
    }

    private fun applyClickToOpen(context: Context, views: RemoteViews) {
        val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
        if (intent != null) {
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)
        }
    }
}
