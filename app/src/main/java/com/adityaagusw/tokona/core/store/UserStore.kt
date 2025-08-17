package com.adityaagusw.tokona.core.store

import android.content.Context
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.adityaagusw.tokona.core.models.user.UserResponse
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

val Context.dataStore by preferencesDataStore(name = "user_store")

class UserStore(private val context: Context) {

    companion object {
        val TOKEN_KEY = stringPreferencesKey("token")
        val NIK_KEY = stringPreferencesKey("nik")
        val NAME_KEY = stringPreferencesKey("name")
        val POSITION_KEY = stringPreferencesKey("position")
        val CREATED_AT_KEY = stringPreferencesKey("created_at")
    }

    suspend fun saveUser(
        nik: String,
        name: String,
        position: String,
        token: String,
        createdAt: String
    ) {
        context.dataStore.edit { preferences ->
            nik.let { preferences[NIK_KEY] = it }
            name.let { preferences[NAME_KEY] = it }
            position.let { preferences[POSITION_KEY] = it }
            token.let { preferences[TOKEN_KEY] = it }
            createdAt.let { preferences[CREATED_AT_KEY] = it }
        }
    }

    val user: Flow<UserResponse?> = context.dataStore.data.map { preferences ->
        val nik = preferences[NIK_KEY]
        val name = preferences[NAME_KEY]
        val position = preferences[POSITION_KEY]
        val token = preferences[TOKEN_KEY]
        val createdAt = preferences[CREATED_AT_KEY]

        if (nik != null && name != null) {
            UserResponse(
                nik = nik.toInt(),
                name = name,
                position = position,
                token = token,
                createdAt = createdAt
            )
        } else {
            null
        }
    }

    suspend fun clearUser() {
        context.dataStore.edit { preferences ->
            preferences.remove(NIK_KEY)
            preferences.remove(NAME_KEY)
            preferences.remove(POSITION_KEY)
            preferences.remove(TOKEN_KEY)
            preferences.remove(CREATED_AT_KEY)
        }
    }
}
