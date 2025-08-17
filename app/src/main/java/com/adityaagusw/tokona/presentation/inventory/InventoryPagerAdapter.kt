package com.adityaagusw.tokona.presentation.inventory

import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.presentation.product.ProductFragment
import com.adityaagusw.tokona.presentation.promo.PromoFragment

class InventoryPagerAdapter(
    fragment: Fragment,
    private val merchant: Merchant,
) : FragmentStateAdapter(fragment) {

    override fun getItemCount(): Int = 2

    override fun createFragment(position: Int): Fragment {
        return when (position) {
            0 -> ProductFragment().apply {
                arguments = Bundle().apply {
                    putParcelable("MerchantArguments", merchant)
                }
            }

            1 -> PromoFragment().apply {
                arguments = Bundle().apply {
                    putParcelable("MerchantArguments", merchant)
                }
            }

            else -> throw IllegalStateException("Invalid position $position")
        }
    }
}
