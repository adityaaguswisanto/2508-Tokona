package com.adityaagusw.tokona.presentation.promo

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.adityaagusw.tokona.core.models.promo.PromoMessage
import com.adityaagusw.tokona.core.models.promo.PromoResponse
import com.adityaagusw.tokona.core.repositories.promo.PromoRepositoryImpl
import com.adityaagusw.tokona.core.helpers.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class PromoViewModel @Inject constructor(
    private val promoRepositoryImpl: PromoRepositoryImpl,
) : ViewModel() {

    private val _promoPostResponse: MutableLiveData<Resource<PromoMessage>> = MutableLiveData()
    val promoPostResponse: LiveData<Resource<PromoMessage>>
        get() = _promoPostResponse

    private val _promoResponse: MutableLiveData<Resource<PromoResponse>> = MutableLiveData()
    val promoResponse: LiveData<Resource<PromoResponse>>
        get() = _promoResponse

    fun post(
        price: Int,
        discount: Int,
        endDate: String,
        productId: Int,
        merchantId: Int,
    ) = viewModelScope.launch {
        _promoPostResponse.value = Resource.Loading
        delay(3000)
        _promoPostResponse.value = promoRepositoryImpl.post(
            price,
            discount,
            endDate,
            productId,
            merchantId,
        )
    }

    fun get(
        merchantId: Int,
        search: String,
        page: Int? = 1,
        limit: Int? = 20,
    ) = viewModelScope.launch {
        _promoResponse.value = Resource.Loading
        try {
            val data = promoRepositoryImpl.promo(
                merchantId = merchantId,
                search = search,
                page = page!!,
                limit = limit!!,
            )
            _promoResponse.value = Resource.Success(PromoResponse(data = data))
        } catch (e: Exception) {
            _promoResponse.value = Resource.Failure(
                isNetworkError = false,
                errorCode = null,
                errorMessage = e.message,
                errorBody = null
            )
        }
    }

}