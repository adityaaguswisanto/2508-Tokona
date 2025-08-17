package com.adityaagusw.tokona.core.sources.local

import androidx.room.Database
import androidx.room.RoomDatabase
import com.adityaagusw.tokona.core.models.attendances.Attendances
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.core.models.promo.Promo
import com.adityaagusw.tokona.core.sources.local.attendances.AttendancesDao
import com.adityaagusw.tokona.core.sources.local.merchant.MerchantDao
import com.adityaagusw.tokona.core.sources.local.product.ProductDao
import com.adityaagusw.tokona.core.sources.local.promo.PromoDao

@Database(entities = [
    Attendances::class,
    Merchant::class,
    Product::class,
    Promo::class,
], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun attendancesDao(): AttendancesDao
    abstract fun merchantDao(): MerchantDao
    abstract fun productDao(): ProductDao
    abstract fun promoDao(): PromoDao
}