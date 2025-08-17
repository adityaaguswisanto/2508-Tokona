package com.adityaagusw.tokona.presentation.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.store.UserStore
import com.adityaagusw.tokona.databinding.HomeBottomSheeetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject
import kotlinx.coroutines.delay

@AndroidEntryPoint
class HomeBottomSheet : BottomSheetDialogFragment() {

    private lateinit var binding: HomeBottomSheeetBinding
    private var loading: Boolean = false

    @Inject
    lateinit var userStore: UserStore

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = HomeBottomSheeetBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun initialBuild() = with(binding) {
        ivClose.setOnClickListener {
            if (loading) {
                return@setOnClickListener
            }
            dismiss()
        }

        btnLogout.setOnClickListener {
            loading = true
            pbLogout.visibility = View.VISIBLE
            btnLogout.visibility = View.GONE
            lifecycleScope.launch {
                delay(3000)
                userStore.clearUser()
                dismiss()
                findNavController().navigate(R.id.action_homeFragment_to_loginFragment)
            }
        }
    }

}