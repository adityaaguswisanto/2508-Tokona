package com.adityaagusw.tokona.core.helpers

import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.ResponseBody
import retrofit2.HttpException

abstract class BaseDataSource {

    suspend fun <T> safeApiCall(
        apiCall: suspend () -> T
    ): Resource<T> {
        return withContext(Dispatchers.IO) {
            try {
                Resource.Success(apiCall.invoke())
            } catch (throwable: Throwable) {
                when (throwable) {
                    is HttpException -> {
                        val errorBody = throwable.response()?.errorBody()
                        val errorMessage = parseErrorMessage(errorBody)
                        Resource.Failure(
                            isNetworkError = false,
                            errorCode = throwable.code(),
                            errorMessage = errorMessage,
                            errorBody = errorBody
                        )
                    }

                    else -> {
                        Resource.Failure(true, null, null, null)
                    }
                }
            }
        }
    }

}

private fun parseErrorMessage(errorBody: ResponseBody?): String? {
    return try {
        errorBody?.string()?.let { json ->
            val map = Gson().fromJson(json, Map::class.java)
            map["message"] as? String
        }
    } catch (e: Exception) {
        null
    }
}
