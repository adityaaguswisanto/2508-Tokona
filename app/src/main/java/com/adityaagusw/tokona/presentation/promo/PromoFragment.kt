package com.adityaagusw.tokona.presentation.promo

import android.os.Build
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.databinding.FragmentPromoBinding
import com.adityaagusw.tokona.presentation.product.QrCodeBottomSheet
import dagger.hilt.android.AndroidEntryPoint
import kotlin.getValue

@AndroidEntryPoint
class PromoFragment : Fragment() {

    private lateinit var binding: FragmentPromoBinding
    private val viewModel: PromoViewModel by activityViewModels()
    private var merchant: Merchant? = null

    private lateinit var promoAdapter: PromoAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentPromoBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        observerPromo()
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun observerPromo() = with(binding) {
        viewModel.promoResponse.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Loading -> {
                    promoAdapter.showShimmer()
                }

                is Resource.Success -> {
                    val data = it.value.data
                    if (data.isNullOrEmpty()) {
                        iclEmptyState.root.visibility = View.VISIBLE
                        iclEmptyState.txtTitle.text = "Informasi Promo"
                        rvPromo.visibility = View.GONE
                    } else {
                        iclEmptyState.root.visibility = View.GONE
                        iclEmptyState.txtTitle.text = "Informasi Promo"
                        rvPromo.visibility = View.VISIBLE
                        promoAdapter.updateData(it.value.data)
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

        if (merchant != null) {
            promo(merchant!!.id, "")
            setupRecyclerView()
        }
    }

    private fun setupRecyclerView() = with(binding) {
        promoAdapter = PromoAdapter(
            emptyList(),
            onQrCodeClick = {
                QrCodeBottomSheet().apply {
                    arguments = Bundle().apply {
                        putParcelable("qrcode", it)
                    }
                    isCancelable = false
                }.show(parentFragmentManager, "QrCodeBottomSheet")
            },
            onItemClick = {

            }
        )
        rvPromo.apply {
            adapter = promoAdapter
            layoutManager = LinearLayoutManager(requireContext())
        }
    }

    private fun promo(
        merchantId: Int,
        search: String,
        page: Int? = 1,
        limit: Int? = 20,
    ) = viewModel.get(
        merchantId = merchantId,
        search = search,
        page = page,
        limit = limit,
    )
}