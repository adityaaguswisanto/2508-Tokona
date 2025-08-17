package com.adityaagusw.tokona.core.models.promo

import android.os.Parcelable
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.parcelize.Parcelize

data class PromoMessage(
    val message: String,
)

@Entity(tableName = "promos")
@Parcelize
data class Promo(
    @PrimaryKey val id: Int = 0,
    val code: String? = "",
    val photo: String? = "",
    val name: String? = "",
    val description: String? = "",
    val price: Int? = 0,
    val discount: Int? = 0,
    val endDate: String? = "",
    val merchantId: Int? = 0,
    val createdAt: String? = "",
    val updatedAt: String? = "",
    val searchKey: String? = "",
    val page: Int = 1,
    @ColumnInfo(name = "page_limit") val limit: Int = 20
) : Parcelable

data class PromoResponse(
    val message: String? = null,
    val data: List<Promo>? = null,
)