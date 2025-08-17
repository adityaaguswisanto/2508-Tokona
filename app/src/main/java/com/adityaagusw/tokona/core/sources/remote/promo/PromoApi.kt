package com.adityaagusw.tokona.core.sources.remote.promo

import com.adityaagusw.tokona.core.models.promo.PromoMessage
import com.adityaagusw.tokona.core.models.promo.PromoResponse
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query

interface PromoApi {

    @FormUrlEncoded
    @POST("promos/create")
    suspend fun post(
        @Field("price") price: Int,
        @Field("discount") discount: Int,
        @Field("end_date") endDate: String,
        @Field("product_id") productId: Int,
        @Field("merchant_id") merchantId: Int,
    ): PromoMessage

    @GET("promos")
    suspend fun get(
        @Query("merchant_id") merchantId: Int,
        @Query("search") search: String? = null,
        @Query("page") page: Int? = 1,
        @Query("limit") limit: Int? = 20,
    ): PromoResponse

}