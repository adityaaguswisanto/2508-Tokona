package com.adityaagusw.tokona.core.repositories.product

import com.adityaagusw.tokona.core.helpers.BaseDataSource
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.core.models.product.ProductAvailableRequest
import com.adityaagusw.tokona.core.sources.local.product.ProductDao
import com.adityaagusw.tokona.core.sources.remote.product.ProductApi
import javax.inject.Inject

class ProductRepositoryImpl @Inject constructor(
    private val productApi: ProductApi,
    private val productDao: ProductDao
) : BaseDataSource() {

    suspend fun product(
        merchantId: Int,
        search: String? = null,
        page: Int = 1,
        limit: Int = 20
    ): List<Product> {
        val searchKey = search ?: ""

        val apiResult = safeApiCall {
            productApi.get(merchantId = merchantId, search = search, page = page, limit = limit)
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
            productDao.clearAll()
            productDao.insertProducts(entities)
            productDao.getProducts(merchantId, searchKey, page, limit)
        } else {
            productDao.getProducts(merchantId, searchKey, page, limit)
        }
    }

    suspend fun put(
        productId: Int,
        available: Int,
    ) = safeApiCall {
        productApi.put(
            productId, ProductAvailableRequest(available)
        )
    }
}