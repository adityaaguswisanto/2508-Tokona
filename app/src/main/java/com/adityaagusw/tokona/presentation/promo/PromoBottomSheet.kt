package com.adityaagusw.tokona.presentation.promo

import android.app.DatePickerDialog
import android.app.Dialog
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.Toast
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.helpers.toRupiah
import com.adityaagusw.tokona.databinding.PromoBottomSheetBinding
import com.adityaagusw.tokona.presentation.inventory.InventoryViewModel
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import dagger.hilt.android.AndroidEntryPoint
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import java.util.TimeZone
import kotlin.getValue

@AndroidEntryPoint
class PromoBottomSheet : BottomSheetDialogFragment() {

    private lateinit var binding: PromoBottomSheetBinding
    private val viewModel: PromoViewModel by viewModels()
    private val viewModelInventory: InventoryViewModel by activityViewModels()

    private var product: Product? = null
    private var loading: Boolean = false

    private var endDatePromo: String? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = PromoBottomSheetBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val dialog = super.onCreateDialog(savedInstanceState) as BottomSheetDialog
        dialog.setOnShowListener { dlg ->
            val bottomSheet =
                (dlg as BottomSheetDialog).findViewById<View>(com.google.android.material.R.id.design_bottom_sheet)
            bottomSheet?.let {
                val behavior = BottomSheetBehavior.from(it)
                behavior.state = BottomSheetBehavior.STATE_EXPANDED
                behavior.isFitToContents = true
            }
        }
        return dialog
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        observerPromo()
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun observerPromo() = with(binding) {
        viewModel.promoPostResponse.observe(viewLifecycleOwner) {
            when (it) {
                is Resource.Loading -> {
                    btnPromo.visibility = View.GONE
                    pbPromo.visibility = View.VISIBLE
                    loading = true
                }

                is Resource.Success -> {
                    viewModelInventory.switchTab(1)
                    parentFragmentManager.setFragmentResult("promoResult", Bundle().apply {
                        putString("response", "Success")
                    })
                    dismiss()
                }

                is Resource.Failure -> {
                    loading = true
                    btnPromo.visibility = View.VISIBLE
                    pbPromo.visibility = View.GONE
                }
            }
        }
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
        txtPrice.text = product?.price?.toRupiah()

        setupDiscount()

        setupEndDate()

        setupPromo()

    }

    private fun setupDiscount() = with(binding) {
        edtDiscount.addTextChangedListener(object : TextWatcher {
            private var current = ""

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {}

            override fun afterTextChanged(s: Editable?) {
                if (s.toString() != current) {
                    edtDiscount.removeTextChangedListener(this)

                    val cleanString = s.toString().replace("[^\\d]".toRegex(), "")

                    if (cleanString.isNotEmpty()) {
                        val parsed = cleanString.toLong()

                        val formatted =
                            "Rp " + NumberFormat.getInstance(Locale("id", "ID")).format(parsed)

                        current = formatted
                        edtDiscount.setText(formatted)
                        edtDiscount.setSelection(formatted.length)
                    } else {
                        current = ""
                        edtDiscount.setText("")
                    }

                    edtDiscount.addTextChangedListener(this)
                }
            }
        })
    }

    private fun setupEndDate() = with(binding) {
        edtEndDate.setOnClickListener {
            val calendar = Calendar.getInstance()
            val year = calendar.get(Calendar.YEAR)
            val month = calendar.get(Calendar.MONTH)
            val day = calendar.get(Calendar.DAY_OF_MONTH)

            val datePickerDialog = DatePickerDialog(
                requireContext(),
                { _, selectedYear, selectedMonth, selectedDay ->
                    val selectedCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"))
                    selectedCalendar.set(selectedYear, selectedMonth, selectedDay, 0, 0, 0)
                    selectedCalendar.set(Calendar.MILLISECOND, 0)

                    val isoFormatter =
                        SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
                    isoFormatter.timeZone = TimeZone.getTimeZone("UTC")
                    endDatePromo = isoFormatter.format(selectedCalendar.time)

                    val readableFormatter = SimpleDateFormat("dd MMMM yyyy", Locale("id", "ID"))
                    binding.edtEndDate.setText(readableFormatter.format(selectedCalendar.time))
                },
                year,
                month,
                day
            )
            datePickerDialog.datePicker.minDate = calendar.timeInMillis
            datePickerDialog.show()
        }
    }

    private fun setupPromo() = with(binding) {
        btnPromo.setOnClickListener {
            edtDiscount.clearFocus()

            val imm =
                requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.hideSoftInputFromWindow(edtDiscount.windowToken, 0)

            val discount = tilDiscount.editText?.text.toString().trim()

            if (discount.isEmpty()) {
                Toast.makeText(requireContext(), "Harga diskon masih kosong", Toast.LENGTH_SHORT)
                    .show()
                return@setOnClickListener
            }

            val discountInt = edtDiscount.text.toString().replace("[^\\d]".toRegex(), "").toInt()

            if (discountInt >= product!!.price!!) {
                Toast.makeText(
                    requireContext(),
                    "Harga diskon tidak boleh lebih besar dari harga produk",
                    Toast.LENGTH_SHORT
                ).show()
                return@setOnClickListener
            }

            if (endDatePromo.isNullOrEmpty()) {
                Toast.makeText(
                    requireContext(),
                    "Tanggal akhir diskon masih kosong",
                    Toast.LENGTH_SHORT
                )
                    .show()
                return@setOnClickListener
            }

            viewModel.post(
                product!!.price!!,
                discountInt,
                endDatePromo.toString(),
                product!!.productId!!,
                product!!.merchantId!!,
            )
        }
    }


}