package com.adityaagusw.tokona.core.sources.local.merchant

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.adityaagusw.tokona.core.models.merchant.Merchant

@Dao
interface MerchantDao {

    @Query("SELECT * FROM merchants WHERE searchKey = :searchKey AND page = :page AND page_limit = :limit")
    suspend fun getMerchants(searchKey: String, page: Int, limit: Int): List<Merchant>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertMerchants(merchants: List<Merchant>)

    @Query("DELETE FROM merchants")
    suspend fun clearAll()
}