package com.adityaagusw.tokona.core.repositories.login

import com.adityaagusw.tokona.core.sources.remote.login.LoginApi
import com.adityaagusw.tokona.core.store.UserStore
import com.adityaagusw.tokona.core.helpers.BaseDataSource
import javax.inject.Inject

class LoginRepositoryImpl @Inject constructor(
    private val loginApi: LoginApi,
    private val userStore: UserStore
) : BaseDataSource() {

    suspend fun login(username: String, password: String) = safeApiCall {
        loginApi.login(username, password)
    }

    suspend fun saveUser(
        nik: String,
        name: String,
        position: String,
        token: String,
        createdAt: String
    ) = userStore.saveUser(
        nik,
        name,
        position,
        token,
        createdAt
    )

}
