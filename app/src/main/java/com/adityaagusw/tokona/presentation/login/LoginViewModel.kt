package com.adityaagusw.tokona.presentation.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.adityaagusw.tokona.core.models.login.LoginResponse
import com.adityaagusw.tokona.core.repositories.login.LoginRepositoryImpl
import com.adityaagusw.tokona.core.helpers.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val loginRepositoryImpl: LoginRepositoryImpl,
) : ViewModel() {

    private val _loginResponse: MutableLiveData<Resource<LoginResponse>> = MutableLiveData()
    val loginResponse: LiveData<Resource<LoginResponse>>
        get() = _loginResponse

    fun login(username: String, password: String) = viewModelScope.launch {
        _loginResponse.value = Resource.Loading
        _loginResponse.value = loginRepositoryImpl.login(username, password)
    }

    suspend fun saveUser(
        nik: String,
        name: String,
        position: String,
        token: String,
        createdAt: String
    ) = loginRepositoryImpl.saveUser(
        nik,
        name,
        position,
        token,
        createdAt
    )

}