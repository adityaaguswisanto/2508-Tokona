package com.adityaagusw.tokona.presentation.splash

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.asLiveData
import androidx.navigation.fragment.findNavController
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.store.UserStore
import com.adityaagusw.tokona.core.helpers.setLightStatusBarIcons
import com.adityaagusw.tokona.core.helpers.setStatusBarColor
import com.adityaagusw.tokona.databinding.FragmentSplashBinding
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class SplashFragment : Fragment() {

    private lateinit var binding: FragmentSplashBinding

    @Inject
    lateinit var userStore: UserStore

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentSplashBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) = with(binding) {
        colorStatusBar()
        navigateToLogin()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun navigateToLogin() {
        Handler(Looper.getMainLooper()).postDelayed({
            userStore.user.asLiveData().observe(viewLifecycleOwner) {
                val goTo = if (it == null) {
                    R.id.action_splashFragment_to_loginFragment
                } else {
                    R.id.action_splashFragment_to_homeFragment
                }
                findNavController().navigate(goTo)
            }
        }, 2000)
    }

    private fun colorStatusBar() {
        val colorInt = ContextCompat.getColor(requireContext(), R.color.orange)
        setStatusBarColor(requireActivity().window, colorInt)
        setLightStatusBarIcons(requireActivity().window)
    }
}