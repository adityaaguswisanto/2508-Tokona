package com.adityaagusw.tokona.core.models.user

data class UserResponse(
    val id: Int? = null,
    val nik: Int? = null,
    val name: String? = null,
    val username: String? = null,
    val position: String? = null,
    val role: String? = null,
    val photo: String? = null,
    val token: String? = null,
    val createdAt: String? = null,
    val updatedAt: String? = null,
)