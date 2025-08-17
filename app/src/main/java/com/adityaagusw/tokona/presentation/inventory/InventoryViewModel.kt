package com.adityaagusw.tokona.presentation.inventory

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class InventoryViewModel @Inject constructor() : ViewModel() {

    private val _selectedTab = MutableLiveData<Int>()
    val selectedTab: LiveData<Int> = _selectedTab

    fun switchTab(tabIndex: Int) {
        _selectedTab.value = tabIndex
    }

    fun resetTab() {
        _selectedTab.value = 0
    }

}