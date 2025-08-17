package com.adityaagusw.tokona.core.repositories.attendances

import com.adityaagusw.tokona.core.sources.remote.attendances.AttendancesApi
import com.adityaagusw.tokona.core.helpers.BaseDataSource
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.models.attendances.Attendances
import com.adityaagusw.tokona.core.models.attendances.AttendancesResponse
import com.adityaagusw.tokona.core.sources.local.attendances.AttendancesDao
import javax.inject.Inject

class AttendancesRepositoryImpl @Inject constructor(
    private val attendancesApi: AttendancesApi,
    private val attendancesDao: AttendancesDao,
) : BaseDataSource() {

    suspend fun attendance(): AttendancesResponse {
        val apiResult = safeApiCall { attendancesApi.attendances() }

        if (apiResult is Resource.Success) {
            val attendanceFromApi = apiResult.value.data
            if (attendanceFromApi != null) {
                attendancesDao.clearAll()
                attendancesDao.insertAttendances(attendanceFromApi)
            }
        }

        val latestAttendance: Attendances? = try {
            attendancesDao.getAttendances()
        } catch (_: Exception) {
            null
        }

        val message: String? = if (apiResult is Resource.Success) apiResult.value.message else null

        return AttendancesResponse(
            message = message,
            data = latestAttendance
        )
    }

    suspend fun create(
        longitude: Float,
        latitude: Float,
        status: Int,
        reason: String? = null,
    ) = safeApiCall {
        attendancesApi.create(
            longitude,
            latitude,
            status,
            reason,
        )
    }

}