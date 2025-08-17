package com.adityaagusw.tokona.core.sources.local.product

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.adityaagusw.tokona.core.models.product.Product

@Dao
interface ProductDao {

    @Query("SELECT * FROM products WHERE merchantId = :merchantId AND searchKey = :searchKey AND page = :page AND page_limit = :limit")
    suspend fun getProducts(
        merchantId: Int,
        searchKey: String,
        page: Int,
        limit: Int
    ): List<Product>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertProducts(products: List<Product>)

    @Query("DELETE FROM products")
    suspend fun clearAll()
}