package com.adityaagusw.tokona.core.sources.remote.product

import com.adityaagusw.tokona.core.models.product.ProductAvailableRequest
import com.adityaagusw.tokona.core.models.product.ProductMessage
import com.adityaagusw.tokona.core.models.product.ProductResponse
import retrofit2.http.Body
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.PUT
import retrofit2.http.Path
import retrofit2.http.Query

interface ProductApi {

    @GET("products")
    suspend fun get(
        @Query("merchant_id") merchantId: Int,
        @Query("search") search: String? = null,
        @Query("page") page: Int? = 1,
        @Query("limit") limit: Int? = 20,
    ): ProductResponse

    @PUT("products/available/{id}")
    suspend fun put(
        @Path("id") productId: Int,
        @Body available: ProductAvailableRequest,
    ): ProductMessage

}