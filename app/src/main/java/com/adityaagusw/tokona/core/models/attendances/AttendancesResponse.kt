package com.adityaagusw.tokona.core.models.attendances

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "attendances")
data class Attendances(
    @PrimaryKey val id: Int = 0,
    val longitude: Float = 0f,
    val latitude: Float = 0f,
    val status: Int = 0,
    val reason: String? = "",
    val createdAt: String? = "",
    val updatedAt: String? = "",
)

data class AttendancesResponse(
    val message: String? = "",
    val data: Attendances? = null,
)