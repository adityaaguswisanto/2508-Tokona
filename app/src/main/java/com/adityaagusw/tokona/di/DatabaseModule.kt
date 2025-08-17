package com.adityaagusw.tokona.di

import android.content.Context
import androidx.room.Room
import com.adityaagusw.tokona.core.sources.local.AppDatabase
import com.adityaagusw.tokona.core.sources.local.attendances.AttendancesDao
import com.adityaagusw.tokona.core.sources.local.merchant.MerchantDao
import com.adityaagusw.tokona.core.sources.local.product.ProductDao
import com.adityaagusw.tokona.core.sources.local.promo.PromoDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    @Provides
    @Singleton
    fun provideAppDatabase(@ApplicationContext context: Context): AppDatabase {
        return Room.databaseBuilder(
            context,
            AppDatabase::class.java,
            "tokona_db"
        ).build()
    }

    @Provides
    @Singleton
    fun provideAttendancesDao(appDatabase: AppDatabase): AttendancesDao {
        return appDatabase.attendancesDao()
    }

    @Provides
    @Singleton
    fun provideMerchantDao(appDatabase: AppDatabase): MerchantDao {
        return appDatabase.merchantDao()
    }

    @Provides
    @Singleton
    fun provideProductDao(appDatabase: AppDatabase): ProductDao {
        return appDatabase.productDao()
    }

    @Provides
    @Singleton
    fun providePromoDao(appDatabase: AppDatabase): PromoDao {
        return appDatabase.promoDao()
    }
}