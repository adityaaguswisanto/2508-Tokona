package com.adityaagusw.tokona.core.sources.local.attendances

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.adityaagusw.tokona.core.models.attendances.Attendances

@Dao
interface AttendancesDao {

    @Query("SELECT * FROM attendances ORDER BY createdAt DESC LIMIT 1")
    suspend fun getAttendances(): Attendances

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAttendances(attendances: Attendances)

    @Query("DELETE FROM attendances")
    suspend fun clearAll()
}