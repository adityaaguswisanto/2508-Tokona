package com.adityaagusw.tokona.core.sources.local.promo

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.adityaagusw.tokona.core.models.promo.Promo

@Dao
interface PromoDao {

    @Query("""
        SELECT * FROM promos p1
        WHERE merchantId = :merchantId
          AND searchKey = :searchKey
          AND page = :page
          AND page_limit = :limit
          AND createdAt = (
              SELECT MAX(createdAt) 
              FROM promos p2 
              WHERE p2.code = p1.code
          )
        ORDER BY datetime(createdAt) DESC
    """)
    suspend fun getPromos(
        merchantId: Int,
        searchKey: String,
        page: Int,
        limit: Int
    ): List<Promo>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertPromos(promos: List<Promo>)

    @Query("DELETE FROM promos WHERE merchantId = :merchantId AND searchKey = :searchKey")
    suspend fun clearPromos(merchantId: Int, searchKey: String)

}