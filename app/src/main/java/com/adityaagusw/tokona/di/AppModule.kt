package com.adityaagusw.tokona.di

import android.content.Context
import com.adityaagusw.tokona.BuildConfig
import com.adityaagusw.tokona.core.store.UserStore
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    fun provideBaseUrl() = BuildConfig.BASE_URL

    @Provides
    @Singleton
    fun provideUserStore(@ApplicationContext context: Context): UserStore {
        return UserStore(context)
    }

}