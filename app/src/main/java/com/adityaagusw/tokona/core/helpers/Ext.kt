package com.adityaagusw.tokona.core.helpers

import android.graphics.Bitmap
import android.os.Build
import android.view.View
import android.view.Window
import android.view.WindowInsets
import android.view.WindowInsetsController
import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel
import com.journeyapps.barcodescanner.BarcodeEncoder
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone

fun setStatusBarColor(window: Window, color: Int) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.VANILLA_ICE_CREAM) {
        window.decorView.setOnApplyWindowInsetsListener { view, insets ->
            val statusBarInsets = insets.getInsets(WindowInsets.Type.statusBars())
            view.setBackgroundColor(color)
            view.setPadding(0, statusBarInsets.top, 0, 0)
            insets
        }
    } else {
        window.statusBarColor = color
    }
}

fun setLightStatusBarIcons(window: Window) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        window.insetsController?.setSystemBarsAppearance(
            0,
            WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS
        )
    } else {
        val decorView = window.decorView
        decorView.systemUiVisibility = decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
    }

}

fun String.toFormattedDate(): String {
    return try {
        val inputFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale("id", "ID"))
        inputFormat.timeZone = TimeZone.getTimeZone("UTC")
        val date: Date = inputFormat.parse(this)!!

        val outputFormat = SimpleDateFormat("dd MMMM yyyy", Locale("id", "ID"))
        outputFormat.timeZone = TimeZone.getTimeZone("Asia/Jakarta")
        outputFormat.format(date)
    } catch (e: Exception) {
        this
    }
}

fun String.toFormattedTime(): String {
    return try {
        val inputFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale("id", "ID"))
        inputFormat.timeZone = TimeZone.getTimeZone("UTC")
        val date: Date = inputFormat.parse(this)!!

        val outputFormat = SimpleDateFormat("HH:mm:ss", Locale("id", "ID"))
        outputFormat.timeZone = TimeZone.getTimeZone("Asia/Jakarta")
        outputFormat.format(date)
    } catch (e: Exception) {
        this
    }
}

fun Int.toRupiah(): String {
    return NumberFormat
        .getCurrencyInstance(Locale("in", "ID"))
        .format(this)
        .replace(",00", "")
}

fun Double.toRupiah(): String {
    return NumberFormat
        .getCurrencyInstance(Locale("in", "ID"))
        .format(this)
        .replace(",00", "")
}

fun String.toRupiah(): String {
    val number = this.toDoubleOrNull() ?: 0.0
    return NumberFormat
        .getCurrencyInstance(Locale("in", "ID"))
        .format(number)
        .replace(",00", "")
}

fun generateQrBitmap(
    content: String,
    size: Int = 512,
    margin: Int = 1,
    ecLevel: ErrorCorrectionLevel = ErrorCorrectionLevel.M
): Bitmap {
    val hints = mapOf(
        EncodeHintType.CHARACTER_SET to "UTF-8",
        EncodeHintType.MARGIN to margin,
        EncodeHintType.ERROR_CORRECTION to ecLevel
    )
    return BarcodeEncoder().encodeBitmap(content, BarcodeFormat.QR_CODE, size, size, hints)
}