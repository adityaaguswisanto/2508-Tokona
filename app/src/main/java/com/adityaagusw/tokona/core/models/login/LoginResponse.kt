package com.adityaagusw.tokona.core.models.login

import com.adityaagusw.tokona.core.models.user.UserResponse

data class LoginResponse(
    val message: String? = null,
    val data: UserResponse? = null
)