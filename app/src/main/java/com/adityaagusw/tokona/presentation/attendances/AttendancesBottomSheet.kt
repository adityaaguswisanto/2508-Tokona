package com.adityaagusw.tokona.presentation.attendances

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.fragment.app.viewModels
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.databinding.AttendancesBottomSheetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class AttendancesBottomSheet : BottomSheetDialogFragment() {

    private lateinit var binding: AttendancesBottomSheetBinding
    private val viewModel: AttendanceViewModel by viewModels()

    private var reason: String? = null
    private var status: Int = 0
    private var loading: Boolean = false

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = AttendancesBottomSheetBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setupObserver()
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun setupObserver() = with(binding) {
        viewModel.attendancesResponse.observe(viewLifecycleOwner, {
            when (it) {
                is Resource.Loading -> {
                    btnAttendances.visibility = View.GONE
                    pbAttendances.visibility = View.VISIBLE
                    loading = true
                }

                is Resource.Success -> {
                    parentFragmentManager.setFragmentResult("attendanceResult", Bundle().apply {
                        putString("response", "Success")
                    })
                    dismiss()
                }

                is Resource.Failure -> {
                    loading = true
                    btnAttendances.visibility = View.VISIBLE
                    pbAttendances.visibility = View.GONE
                }
            }
        })
    }

    private fun initialBuild() = with(binding) {
        status = arguments?.getInt("status") ?: 0

        if(status == 2) {
            status = 0
        }

        println("wkwkwk : $status")

        setupAttendancesRadioButton()

        ivClose.setOnClickListener {
            if (loading) {
                return@setOnClickListener
            }
            dismiss()
        }

        btnAttendances.setOnClickListener {
            if (status == 0) {
                Toast.makeText(requireContext(), "Harus dipilih", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (status == 2 && reason == "Pilih Alasan") {
                Toast.makeText(requireContext(), "Harus dipilih", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            viewModel.create(106.827153f, -6.175110f, status, reason)
        }
    }

    private fun setupAttendancesRadioButton() = with(binding) {
        rbMasukKerja.text = if (status == 1) "Pulang Kerja" else "Masuk Kerja"
        rbAbsen.visibility = if(status == 1) View.GONE else View.VISIBLE
        radioGroup.setOnCheckedChangeListener { _, checkedId ->
            when (checkedId) {
                R.id.rbMasukKerja -> {
                    status = if (status == 1) {
                        2
                    } else {
                        1
                    }
                    llSpnReason.visibility = View.GONE
                    setupReasonSpinner()
                }

                R.id.rbAbsen -> {
                    status = 2
                    llSpnReason.visibility = View.VISIBLE
                    setupReasonSpinner()
                }
            }
        }
    }

    private fun setupReasonSpinner() = with(binding) {
        val reasons = listOf(
            "Pilih Alasan",
            "Sakit / Tidak Fit",
            "Izin Pribadi",
            "Cuti Tahunan",
            "Kegiatan Keluarga",
            "Transportasi / Kendala Perjalanan",
            "Work From Home",
            "Dinas Luar Kota",
            "Lainnya"
        )

        val adapter = ArrayAdapter(
            requireContext(),
            android.R.layout.simple_spinner_item,
            reasons
        )
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spnReason.adapter = adapter

        spnReason.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                parent: AdapterView<*>,
                view: View?,
                position: Int,
                id: Long
            ) {
                reason = reasons[position]
            }

            override fun onNothingSelected(parent: AdapterView<*>) {

            }
        }
    }

}
