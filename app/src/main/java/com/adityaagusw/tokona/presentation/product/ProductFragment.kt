package com.adityaagusw.tokona.presentation.product

import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.databinding.FragmentProductBinding
import com.adityaagusw.tokona.presentation.promo.PromoViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class ProductFragment() : Fragment() {

    private lateinit var binding: FragmentProductBinding
    private val viewModel: ProductViewModel by activityViewModels()
    private val viewModelPromo: PromoViewModel by activityViewModels()
    private var merchant: Merchant? = null

    private lateinit var productAdapter: ProductAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProductBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        observerProduct()
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun observerProduct() = with(binding) {
        viewModel.productResponse.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Loading -> {
                    productAdapter.showShimmer()
                }

                is Resource.Success -> {
                    val data = it.value.data
                    if (data.isNullOrEmpty()) {
                        iclEmptyState.root.visibility = View.VISIBLE
                        rvProducts.visibility = View.GONE
                    } else {
                        iclEmptyState.root.visibility = View.GONE
                        rvProducts.visibility = View.VISIBLE
                        productAdapter.updateData(it.value.data)
                    }
                }

                is Resource.Failure -> {
                    Toast.makeText(requireContext(), it.errorMessage ?: "Terjadi kesalahan lain", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    private fun initialBuild() {
        merchant = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            arguments?.getParcelable("MerchantArguments", Merchant::class.java)
        } else {
            @Suppress("DEPRECATION")
            arguments?.getParcelable("MerchantArguments")
        } ?: throw IllegalArgumentException("MerchantArguments tidak boleh null")

        resultBottomSheet()

        if (merchant != null) {
            product(merchant!!.id, "")
            setupRecyclerView()
        }
    }

    private fun setupRecyclerView() = with(binding) {
        productAdapter = ProductAdapter(
            emptyList(),
            onQrCodeClick = {
                QrCodeBottomSheet().apply {
                    arguments = Bundle().apply {
                        putParcelable("product", it)
                    }
                    isCancelable = false
                }.show(parentFragmentManager, "QrCodeBottomSheet")
            },
            onItemClick = {
                MenuBottomSheet().apply {
                    arguments = Bundle().apply {
                        putParcelable("product", it)
                    }
                    isCancelable = false
                }.show(parentFragmentManager, "MenuBottomSheet")
            }
        )
        rvProducts.apply {
            adapter = productAdapter
            layoutManager = LinearLayoutManager(requireContext())
        }
    }

    private fun resultBottomSheet() {
        parentFragmentManager.setFragmentResultListener(
            "productResult",
            viewLifecycleOwner
        ) { key, bundle ->
            product(merchant!!.id, "")
        }

        parentFragmentManager.setFragmentResultListener(
            "promoResult",
            viewLifecycleOwner
        ) { key, bundle ->
            promo(merchant!!.id, "")
        }
    }

    private fun product(
        merchantId: Int,
        search: String,
        page: Int? = 1,
        limit: Int? = 20,
    ) = viewModel.product(
        merchantId = merchantId,
        search = search,
        page = page,
        limit = limit,
    )

    private fun promo(
        merchantId: Int,
        search: String,
        page: Int? = 1,
        limit: Int? = 20,
    ) = viewModelPromo.get(
        merchantId = merchantId,
        search = search,
        page = page,
        limit = limit,
    )

}