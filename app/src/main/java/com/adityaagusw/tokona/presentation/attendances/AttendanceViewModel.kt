package com.adityaagusw.tokona.presentation.attendances

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.adityaagusw.tokona.core.models.attendances.AttendancesResponse
import com.adityaagusw.tokona.core.repositories.attendances.AttendancesRepositoryImpl
import com.adityaagusw.tokona.core.helpers.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AttendanceViewModel @Inject constructor(
    private val attendancesRepositoryImpl: AttendancesRepositoryImpl,
) : ViewModel() {

    private val _attendancesResponse: MutableLiveData<Resource<AttendancesResponse>> =
        MutableLiveData()
    val attendancesResponse: LiveData<Resource<AttendancesResponse>>
        get() = _attendancesResponse

    fun create(
        longitude: Float,
        latitude: Float,
        status: Int,
        reason: String?  = null,
    ) = viewModelScope.launch {
        _attendancesResponse.value = Resource.Loading
        delay(3000)
        _attendancesResponse.value = attendancesRepositoryImpl.create(
            longitude,
            latitude,
            status,
            reason,
        )
    }

}