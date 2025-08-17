package com.adityaagusw.tokona.core.helpers

import com.google.gson.annotations.SerializedName

data class ErrorResponse(
    @SerializedName("message") val message: String? = null,
)