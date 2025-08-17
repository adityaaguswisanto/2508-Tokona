package com.adityaagusw.tokona.core.models.merchant

import android.os.Parcelable
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.parcelize.Parcelize

@Entity(tableName = "merchants")
@Parcelize
data class Merchant(
    @PrimaryKey val id: Int = 0,
    val code: String? = "",
    val name: String? = "",
    val address: String? = "",
    val createdAt: String? = "",
    val updatedAt: String? = "",
    val searchKey: String? = "",
    val page: Int = 1,
    @ColumnInfo(name = "page_limit") val limit: Int = 20
) : Parcelable

data class MerchantResponse(
    val message: String? = null,
    val data: List<Merchant>? = null,
)