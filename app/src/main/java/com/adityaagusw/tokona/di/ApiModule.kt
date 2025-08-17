package com.adityaagusw.tokona.di

import com.adityaagusw.tokona.core.sources.remote.attendances.AttendancesApi
import com.adityaagusw.tokona.core.sources.remote.login.LoginApi
import com.adityaagusw.tokona.core.sources.remote.merchant.MerchantApi
import com.adityaagusw.tokona.core.sources.remote.product.ProductApi
import com.adityaagusw.tokona.core.sources.remote.promo.PromoApi
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object ApiModule {

    @Provides
    @Singleton
    fun provideLoginApi(retrofit: Retrofit): LoginApi =
        retrofit.create(LoginApi::class.java)

    @Provides
    @Singleton
    fun provideAttendancesApi(retrofit: Retrofit): AttendancesApi =
        retrofit.create(AttendancesApi::class.java)

    @Provides
    @Singleton
    fun provideMerchantsApi(retrofit: Retrofit): MerchantApi =
        retrofit.create(MerchantApi::class.java)

    @Provides
    @Singleton
    fun provideProductApi(retrofit: Retrofit): ProductApi =
        retrofit.create(ProductApi::class.java)

    @Provides
    @Singleton
    fun providePromoApi(retrofit: Retrofit): PromoApi =
        retrofit.create(PromoApi::class.java)

}