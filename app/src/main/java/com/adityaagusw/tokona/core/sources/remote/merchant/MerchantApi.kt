package com.adityaagusw.tokona.core.sources.remote.merchant

import com.adityaagusw.tokona.core.models.merchant.MerchantResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface MerchantApi {

    @GET("merchants")
    suspend fun get(
        @Query("search") search: String? = null,
        @Query("page") page: Int? = 1,
        @Query("limit") limit: Int? = 20,
    ): MerchantResponse

}