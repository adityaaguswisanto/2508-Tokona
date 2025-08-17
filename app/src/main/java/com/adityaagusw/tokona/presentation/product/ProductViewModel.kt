package com.adityaagusw.tokona.presentation.product

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.adityaagusw.tokona.core.models.product.ProductMessage
import com.adityaagusw.tokona.core.models.product.ProductResponse
import com.adityaagusw.tokona.core.repositories.product.ProductRepositoryImpl
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.models.merchant.MerchantResponse
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ProductViewModel @Inject constructor(
    private val productRepositoryImpl: ProductRepositoryImpl,
) : ViewModel() {

    private val _productPutResponse: MutableLiveData<Resource<ProductMessage>> = MutableLiveData()
    val productPutResponse: LiveData<Resource<ProductMessage>>
        get() = _productPutResponse

    private val _productResponse: MutableLiveData<Resource<ProductResponse>> =
        MutableLiveData()
    val productResponse: LiveData<Resource<ProductResponse>>
        get() = _productResponse

    fun put(
        productId: Int,
        available: Int,
    ) = viewModelScope.launch {
        _productPutResponse.value = Resource.Loading
        _productPutResponse.value = productRepositoryImpl.put(
            productId, available
        )
    }

    fun product(
        merchantId: Int,
        search: String,
        page: Int? = 1,
        limit: Int? = 20,
    ) = viewModelScope.launch {
        _productResponse.value = Resource.Loading
        delay(2000)
        try {
            val data = productRepositoryImpl.product(
                merchantId = merchantId,
                search = search,
                page = page!!,
                limit = limit!!,
            )
            _productResponse.value = Resource.Success(ProductResponse(data = data))
        } catch (e: Exception) {
            _productResponse.value = Resource.Failure(
                isNetworkError = false,
                errorCode = null,
                errorMessage = e.message,
                errorBody = null
            )
        }
    }


}