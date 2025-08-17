package com.adityaagusw.tokona.core.paging

import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.core.sources.local.merchant.MerchantDao
import com.adityaagusw.tokona.core.sources.remote.merchant.MerchantApi
import kotlinx.coroutines.delay
import javax.inject.Inject

class MerchantPagingSource @Inject constructor(
    private val merchantApi: MerchantApi,
    private val merchantDao: MerchantDao,
    private val search: String = "",
    private val limit: Int = 10
) : PagingSource<Int, Merchant>() {

    override fun getRefreshKey(state: PagingState<Int, Merchant>): Int? {
        return state.anchorPosition?.let { position ->
            state.closestPageToPosition(position)?.prevKey?.plus(1)
                ?: state.closestPageToPosition(position)?.nextKey?.minus(1)
        }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, Merchant> {
        val page = params.key ?: 1

        return try {
            delay(2000)
            val response = merchantApi.get(search = search, page = page, limit = limit)
            val data = response.data ?: emptyList()

            val entities = data.map { it.copy(searchKey = search, page = page, limit = limit) }
            merchantDao.insertMerchants(entities)

            LoadResult.Page(
                data = data,
                prevKey = if (page == 1) null else page - 1,
                nextKey = if (data.size < limit) null else page + 1
            )

        } catch (e: Exception) {
            val cached = merchantDao.getMerchants(search, page, limit)
            if (cached.isNotEmpty()) {
                LoadResult.Page(
                    data = cached,
                    prevKey = if (page == 1) null else page - 1,
                    nextKey = if (cached.size < limit) null else page + 1
                )
            } else {
                LoadResult.Error(e)
            }
        }
    }
}