package com.adityaagusw.tokona.presentation.product
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.databinding.MenuBottomSheetBinding
import com.adityaagusw.tokona.presentation.promo.PromoBottomSheet
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MenuBottomSheet : BottomSheetDialogFragment() {

    private lateinit var binding: MenuBottomSheetBinding
    private var product: Product? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = MenuBottomSheetBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun initialBuild() = with(binding) {
        product = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            arguments?.getParcelable("product", Product::class.java)
        } else {
            arguments?.getParcelable("product")
        }

        ivClose.setOnClickListener {
            dismiss()
        }
        btnDetailProduct.setOnClickListener {
            ProductBottomSheet().apply {
                arguments = Bundle().apply {
                    putParcelable("product", product)
                }
                isCancelable = false
            }.show(parentFragmentManager, "ProductBottomSheet")
            dismiss()
        }
        btnCreatePromo.setOnClickListener {
            PromoBottomSheet().apply {
                arguments = Bundle().apply {
                    putParcelable("product", product)
                }
                isCancelable = false
            }.show(parentFragmentManager, "PromoBottomSheet")
            dismiss()
        }
    }

}