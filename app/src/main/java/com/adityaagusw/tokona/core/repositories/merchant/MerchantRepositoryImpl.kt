package com.adityaagusw.tokona.core.repositories.merchant

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import androidx.paging.cachedIn
import com.adityaagusw.tokona.core.helpers.BaseDataSource
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.core.paging.MerchantPagingSource
import com.adityaagusw.tokona.core.sources.local.merchant.MerchantDao
import com.adityaagusw.tokona.core.sources.remote.merchant.MerchantApi
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class MerchantRepositoryImpl @Inject constructor(
    private val merchantApi: MerchantApi,
    private val merchantDao: MerchantDao
) : BaseDataSource() {

    private var merchantPagingSource: MerchantPagingSource? = null

    fun merchant(
        search: String? = ""
    ): Flow<PagingData<Merchant>> {
        return Pager(
            config = PagingConfig(
                pageSize = 5,
                initialLoadSize = 5
            ),
            pagingSourceFactory = {
                MerchantPagingSource(merchantApi, merchantDao, search.toString())
                    .also { merchantPagingSource = it }
            }
        ).flow.cachedIn(CoroutineScope(Dispatchers.IO))
    }
}