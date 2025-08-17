package com.adityaagusw.tokona.core.sources.remote.attendances

import com.adityaagusw.tokona.core.models.attendances.AttendancesResponse
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST

interface AttendancesApi {

    @GET("attendances/")
    suspend fun attendances(): AttendancesResponse

    @FormUrlEncoded
    @POST("attendances/create")
    suspend fun create(
        @Field("longitude") longitude: Float,
        @Field("latitude") latitude: Float,
        @Field("status") status: Int,
        @Field("reason") reason: String? = null,
    ): AttendancesResponse
}