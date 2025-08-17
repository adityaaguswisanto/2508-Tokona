package com.adityaagusw.tokona.presentation.product

import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.core.helpers.generateQrBitmap
import com.adityaagusw.tokona.databinding.QrCodeBottomSheetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class QrCodeBottomSheet : BottomSheetDialogFragment() {

    private lateinit var binding: QrCodeBottomSheetBinding

    private var product: Product? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = QrCodeBottomSheetBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun initialBuild() = with(binding) {
        product = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            arguments?.getParcelable("qrcode", Product::class.java)
        } else {
            arguments?.getParcelable("qrcode")
        }

        ivClose.setOnClickListener {
            dismiss()
        }

        val qrBitmap = generateQrBitmap(
            content = product?.id.toString(),
            size = 512,
            margin = 1,
            ecLevel = com.google.zxing.qrcode.decoder.ErrorCorrectionLevel.M
        )

        ivQrCode.setImageBitmap(qrBitmap)
    }


}