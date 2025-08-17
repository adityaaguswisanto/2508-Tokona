package com.adityaagusw.tokona.presentation.login

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.databinding.FragmentLoginBinding
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

@AndroidEntryPoint
class LoginFragment : Fragment() {

    private lateinit var binding: FragmentLoginBinding
    private val viewModel: LoginViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentLoginBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setupObserver()
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun setupObserver() {
        viewModel.loginResponse.observe(viewLifecycleOwner, {
            when (it) {
                is Resource.Loading -> {
                    btnGone()
                }

                is Resource.Success -> {
                    pbGone()
                    lifecycleScope.launch {
                        viewModel.saveUser(
                            it.value.data?.nik.toString(),
                            it.value.data?.name.toString(),
                            it.value.data?.position.toString(),
                            it.value.data?.token.toString(),
                            it.value.data?.createdAt.toString()
                        )
                        findNavController().navigate(R.id.action_loginFragment_to_homeFragment)
                    }
                }

                is Resource.Failure -> {
                    pbGone()
                    Toast.makeText(requireContext(), it.errorMessage ?: "Terjadi kesalahan lain", Toast.LENGTH_SHORT).show()
                }
            }
        })
    }

    private fun initialBuild() = with(binding) {

        btnLogin.setOnClickListener {
            val username = tilUsername.editText?.text.toString().trim()
            val password = tilPassword.editText?.text.toString().trim()

            if (username.isEmpty()) {
                Toast.makeText(requireContext(), "Username masih kosong", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (password.isEmpty()) {
                Toast.makeText(requireContext(), "Password masih kosong", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            viewModel.login(
                username,
                password
            )
        }
    }

    private fun pbGone() = with(binding) {
        pbLogin.visibility = View.GONE
        btnLogin.visibility = View.VISIBLE
    }

    private fun btnGone() = with(binding) {
        pbLogin.visibility = View.VISIBLE
        btnLogin.visibility = View.GONE
    }

}