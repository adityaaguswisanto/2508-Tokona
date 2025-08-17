package com.adityaagusw.tokona.presentation.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.PagingData
import androidx.paging.cachedIn
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.models.attendances.AttendancesResponse
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.core.repositories.attendances.AttendancesRepositoryImpl
import com.adityaagusw.tokona.core.repositories.merchant.MerchantRepositoryImpl
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.debounce
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val attendancesRepositoryImpl: AttendancesRepositoryImpl,
    private val merchantRepositoryImpl: MerchantRepositoryImpl,
) : ViewModel() {

    private val _attendancesResponse: MutableLiveData<Resource<AttendancesResponse>> =
        MutableLiveData()
    val attendancesResponse: LiveData<Resource<AttendancesResponse>>
        get() = _attendancesResponse

    private val search = MutableStateFlow("")

    fun attendances() = viewModelScope.launch {
        _attendancesResponse.value = Resource.Loading

        try {
            val response = attendancesRepositoryImpl.attendance()
            _attendancesResponse.value = Resource.Success(response)
        } catch (e: Exception) {
            _attendancesResponse.value = Resource.Failure(
                isNetworkError = true,
                errorCode = null,
                errorMessage = e.message ?: "Unknown error",
                errorBody = null
            )
        }
    }

    @OptIn(FlowPreview::class, ExperimentalCoroutinesApi::class)
    val merchantResponse: Flow<PagingData<Merchant>> =
        search
            .debounce(0)
            .distinctUntilChanged()
            .flatMapLatest { query ->
                merchantRepositoryImpl.merchant(query)
            }
            .cachedIn(viewModelScope)

    fun setSearch(query: String) {
        search.value = query
    }

}