package com.adityaagusw.tokona.core.models.product

import android.os.Parcelable
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.parcelize.Parcelize

data class ProductAvailableRequest(
    val available: Int
)

data class ProductMessage(
    val message: String,
)

@Entity(tableName = "products")
@Parcelize
data class Product(
    @PrimaryKey val id: Int = 0,
    val code: String? = "",
    val photo: String? = "",
    val name: String? = "",
    val description: String? = "",
    val price: Int? = 0,
    val available: Int? = 0,
    val productId: Int? = 0,
    val merchantId: Int? = 0,
    val createdAt: String? = "",
    val updatedAt: String? = "",
    val searchKey: String? = "",
    val page: Int = 1,
    @ColumnInfo(name = "page_limit") val limit: Int = 20
) : Parcelable

data class ProductResponse(
    val message: String? = null,
    val data: List<Product>? = null,
)