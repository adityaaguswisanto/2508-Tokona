package com.adityaagusw.tokona.presentation.inventory

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.navArgs
import com.adityaagusw.tokona.databinding.FragmentInventoryBinding
import com.google.android.material.tabs.TabLayoutMediator
import dagger.hilt.android.AndroidEntryPoint
import androidx.activity.OnBackPressedCallback
import com.adityaagusw.tokona.presentation.product.ProductViewModel
import com.adityaagusw.tokona.presentation.promo.PromoViewModel
import com.google.android.material.tabs.TabLayout
import kotlin.getValue

@AndroidEntryPoint
class InventoryFragment : Fragment() {

    private lateinit var binding: FragmentInventoryBinding
    private val viewModel: InventoryViewModel by activityViewModels()
    private val viewModelProduct: ProductViewModel by activityViewModels()
    private val viewModelPromo: PromoViewModel by activityViewModels()

    private val args: InventoryFragmentArgs by navArgs()

    private var tabBar: Int = 0

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentInventoryBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun initialBuild() = with(binding) {
        toolBar()
        setupTabBar()
        observerTabBar()
        search()
    }

    private fun toolBar() = with(binding) {
        setupBackPress()
        ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
        txtTitle.text = args.MerchantArguments.name
        txtDescription.text = args.MerchantArguments.address

        ivSearch.setOnClickListener {
            tilSearch.visibility = View.VISIBLE
            val editText = tilSearch.editText
            editText?.requestFocus()
            val imm =
                requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.showSoftInput(editText, InputMethodManager.SHOW_IMPLICIT)
        }
    }

    private fun search() = with(binding) {
        edtSearch.setOnEditorActionListener { view, actionId, _ ->
            if (actionId == EditorInfo.IME_ACTION_GO) {
                val search = tilSearch.editText?.text.toString().trim()
                if (tabBar == 0) {
                    product(args.MerchantArguments.id, search, 1, 20)
                } else if (tabBar == 1) {
                    promo(args.MerchantArguments.id, search, 1, 20)
                }
                val imm =
                    requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.hideSoftInputFromWindow(view.windowToken, 0)

                true
            } else {
                false
            }
        }
    }

    private fun setupTabBar() = with(binding) {
        val adapter = InventoryPagerAdapter(this@InventoryFragment, args.MerchantArguments)
        viewPager.adapter = adapter

        TabLayoutMediator(tabLayout, viewPager) { tab, position ->
            tab.text = when (position) {
                0 -> "Product"
                1 -> "Promo"
                else -> ""
            }
        }.attach()

        tabLayout.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab?) {
                tab?.let {
                    tabBar = it.position
                }
            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {}
            override fun onTabReselected(tab: TabLayout.Tab?) {}
        })
    }

    private fun observerTabBar() = with(binding) {
        viewModel.selectedTab.observe(viewLifecycleOwner) { tabIndex ->
            viewPager.currentItem = tabIndex
        }
    }

    private fun product(
        merchantId: Int,
        search: String,
        page: Int? = 1,
        limit: Int? = 20,
    ) = viewModelProduct.product(
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

    private fun setupBackPress() {
        val callback = object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                viewModel.resetTab()
                isEnabled = false
                requireActivity().onBackPressed()
            }
        }

        requireActivity().onBackPressedDispatcher.addCallback(viewLifecycleOwner, callback)
    }
}