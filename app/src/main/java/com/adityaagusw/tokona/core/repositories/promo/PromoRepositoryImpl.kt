package com.adityaagusw.tokona.core.repositories.promo

import com.adityaagusw.tokona.core.helpers.BaseDataSource
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.models.promo.Promo
import com.adityaagusw.tokona.core.sources.local.promo.PromoDao
import com.adityaagusw.tokona.core.sources.remote.promo.PromoApi
import javax.inject.Inject

class PromoRepositoryImpl @Inject constructor(
    private val promoApi: PromoApi,
    private val promoDao: PromoDao
) : BaseDataSource() {

    suspend fun post(
        price: Int,
        discount: Int,
        endDate: String,
        productId: Int,
        merchantId: Int,
    ) = safeApiCall {
        promoApi.post(
            price,
            discount,
            endDate,
            productId,
            merchantId
        )
    }

    suspend fun promo(
        merchantId: Int,
        search: String? = null,
        page: Int = 1,
        limit: Int = 20,
    ): List<Promo> {
        val searchKey = search ?: ""

        val apiResult = safeApiCall {
            promoApi.get(merchantId = merchantId, search = search, page = page, limit = limit)
        }

        return if (apiResult is Resource.Success) {
            val response = apiResult.value.data ?: emptyList()
            val entities = response.map {
                it.copy(
                    merchantId = merchantId,
                    searchKey = searchKey,
                    page = page,
                    limit = limit
                )
            }
            promoDao.clearPromos(merchantId, searchKey)
            promoDao.insertPromos(entities)
            promoDao.getPromos(merchantId, searchKey, page, limit)
        } else {
            // Offline / API gagal
            promoDao.getPromos(merchantId, searchKey, page, limit)
        }
    }
}