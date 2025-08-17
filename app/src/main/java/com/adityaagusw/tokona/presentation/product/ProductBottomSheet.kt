package com.adityaagusw.tokona.presentation.product

import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.viewModels
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.databinding.ProductBottomSheetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class ProductBottomSheet : BottomSheetDialogFragment() {

    private lateinit var binding: ProductBottomSheetBinding
    private val viewModel: ProductViewModel by viewModels()

    private var product: Product? = null
    private var available: Int? = 0
    private var loading: Boolean = false

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = ProductBottomSheetBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setupObserver()
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun setupObserver() = with(binding) {
        viewModel.productPutResponse.observe(viewLifecycleOwner, {
            when (it) {
                is Resource.Loading -> {
                    btnAvailable.visibility = View.GONE
                    pbProduct.visibility = View.VISIBLE
                    loading = true
                }

                is Resource.Success -> {
                    parentFragmentManager.setFragmentResult("productResult", Bundle().apply {
                        putString("response", "Success")
                    })
                    dismiss()
                }

                is Resource.Failure -> {
                    loading = true
                    btnAvailable.visibility = View.VISIBLE
                    pbProduct.visibility = View.GONE
                }
            }
        })
    }

    private fun initialBuild() = with(binding) {

        product = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            arguments?.getParcelable("product", Product::class.java)
        } else {
            arguments?.getParcelable("product")
        }

        ivClose.setOnClickListener {
            if (loading) {
                return@setOnClickListener
            }
            dismiss()
        }

        txtName.text = product?.name
        txtDescription.text = product?.description

        cbAvailable.setOnCheckedChangeListener { _, isChecked ->
            available = if (isChecked) {
                1
            } else {
                0
            }
        }

        btnAvailable.setOnClickListener {
            if (available == 0) {
                Toast.makeText(requireContext(), "Harus dipilih", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            viewModel.put(product!!.id, available!!)
        }

    }

}