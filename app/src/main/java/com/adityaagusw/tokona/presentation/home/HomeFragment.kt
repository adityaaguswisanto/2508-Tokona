package com.adityaagusw.tokona.presentation.home

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.TextView
import android.widget.Toast
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.asLiveData
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.paging.LoadState
import androidx.recyclerview.widget.LinearLayoutManager
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.helpers.LoadStateAdapter
import com.adityaagusw.tokona.core.helpers.Resource
import com.adityaagusw.tokona.core.helpers.toFormattedDate
import com.adityaagusw.tokona.core.models.attendances.Attendances
import com.adityaagusw.tokona.core.paging.MerchantPagingAdapter
import com.adityaagusw.tokona.core.store.UserStore
import com.adityaagusw.tokona.databinding.FragmentHomeBinding
import com.adityaagusw.tokona.presentation.attendances.AttendancesBottomSheet
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import javax.inject.Inject

@AndroidEntryPoint
class HomeFragment : Fragment() {

    private lateinit var binding: FragmentHomeBinding
    private val viewModel: HomeViewModel by viewModels()

    private var stopwatchHandler: Handler? = null
    private var stopwatchRunnable: Runnable? = null

    private var status: Int? = 0
    private var loading: Boolean = false

    private val merchantAdapter = MerchantPagingAdapter {
        val action = HomeFragmentDirections.actionHomeFragmentToInventoryFragment(it)
        findNavController().navigate(action)
    }

    @Inject
    lateinit var userStore: UserStore

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        initialBuild()
        super.onViewCreated(view, savedInstanceState)
    }

    private fun initialBuild() = with(binding) {
        setupLoadStateFlow()
        logout()
        observerAttendances()
        attendances()
        search()
    }

    @SuppressLint("SetTextI18n")
    private fun observerAttendances() = with(binding) {
        viewModel.attendancesResponse.observe(viewLifecycleOwner, {
            when (it) {
                is Resource.Loading -> {
                    iclAttendanceShimmer.root.visibility = View.VISIBLE
                    mcvProfile.visibility = View.GONE
                }

                is Resource.Success -> {
                    iclAttendanceShimmer.root.visibility = View.GONE
                    mcvProfile.visibility = View.VISIBLE
                    val data = it.value.data
                    if (data == null) {
                        setupNull()
                    } else {
                        status = data.status
                        if (status == 1) {
                            setupCheckin(data)
                        } else if (status == 2) {
                            setupCheckout(data)
                        }
                    }
                }

                is Resource.Failure -> {
                    iclAttendanceShimmer.root.visibility = View.VISIBLE
                    mcvProfile.visibility = View.GONE
                    Toast.makeText(requireContext(), it.errorMessage ?: "Terjadi kesalahan lain", Toast.LENGTH_SHORT).show()
                }
            }
        })
    }

    private fun setupNull() = with(binding) {
        txtWorkingHours.text = "00:00:00"
        txtStatus.text = "Check in"
        rvMerchant.visibility = View.GONE
        iclAttendancesItem.root.visibility = View.VISIBLE
        iclAttendancesItem.btnCheckin.setOnClickListener {
            AttendancesBottomSheet().apply {
                arguments = Bundle().apply {
                    putInt("status", status ?: 0)
                }
                isCancelable = false
            }.show(parentFragmentManager, "AttendancesBottomSheet")
        }
    }

    private fun setupCheckin(attendances: Attendances?) = with(binding) {
        rvMerchant.visibility = View.VISIBLE
        txtStatus.text = "Check out"
        txtTitleWorkingHours.text = "Working Hours"
        startStopwatch(attendances?.createdAt.toString())
        rvMerchant.visibility = View.VISIBLE
        iclAttendancesItem.root.visibility = View.GONE
        setupRecyclerView()
    }

    private fun setupCheckout(attendances: Attendances?) = with(binding) {
        rvMerchant.visibility = View.GONE
        iclAttendancesItem.root.visibility = View.VISIBLE
        iclAttendancesItem.btnCheckin.setOnClickListener {
            AttendancesBottomSheet().apply {
                arguments = Bundle().apply {
                    putInt("status", status ?: 0)
                }
                isCancelable = false
            }.show(parentFragmentManager, "AttendancesBottomSheet")
        }
        txtStatus.text = "Check in"
        txtTitleWorkingHours.text =
            if (attendances?.reason == null) "Working Hours" else "Reason"
        txtWorkingHours.text = attendances?.reason ?: "00:00:00"
        stopwatchRunnable?.let { runnable ->
            stopwatchHandler?.removeCallbacks(runnable)
        }
    }

    private fun logout() = with(binding) {
        txtLogout.setOnClickListener {
            HomeBottomSheet().apply {
                isCancelable = false
            }.show(parentFragmentManager, "HomeBottomSheet")
        }
    }

    @SuppressLint("SetTextI18n")
    private fun attendances() = with(binding) {
        viewModel.attendances()

        userStore.user.asLiveData().observe(viewLifecycleOwner) {
            txtName.text = it?.name
            txtBiodata.text = "${it?.nik} - ${it?.position}"
            txtMemberSince.text = it?.createdAt?.toFormattedDate()
        }

        parentFragmentManager.setFragmentResultListener(
            "attendanceResult",
            viewLifecycleOwner
        ) { key, bundle ->
            viewModel.attendances()
        }

        btnAttendances.setOnClickListener {
            AttendancesBottomSheet().apply {
                arguments = Bundle().apply {
                    putInt("status", status ?: 0)
                }
                isCancelable = false
            }.show(parentFragmentManager, "AttendancesBottomSheet")
        }
    }

    private fun search() = with(binding) {
        edtSearch.setOnEditorActionListener { view, actionId, _ ->
            if (actionId == EditorInfo.IME_ACTION_GO) {
                if (loading) {
                    Toast.makeText(requireContext(), "Loading, please wait...", Toast.LENGTH_SHORT)
                        .show()
                    return@setOnEditorActionListener true
                }
                val search = tilSearch.editText?.text.toString().trim()
                viewModel.setSearch(search)
                val imm =
                    requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.hideSoftInputFromWindow(view.windowToken, 0)

                true
            } else {
                false
            }
        }
    }

    private fun setupLoadStateFlow() = with(binding) {
        lifecycleScope.launch {
            merchantAdapter.loadStateFlow.collectLatest { loadStates ->
                val isLoading = loadStates.refresh is LoadState.Loading
                iclMerchant.root.isVisible = isLoading && merchantAdapter.itemCount == 0
                loading = isLoading && merchantAdapter.itemCount == 0
                rvMerchant.isVisible = !isLoading || merchantAdapter.itemCount > 0

                val isEmpty = loadStates.refresh is LoadState.NotLoading && merchantAdapter.itemCount == 0
                iclEmptyState.root.isVisible = isEmpty
                val txtTitle = iclEmptyState.root.findViewById<TextView>(R.id.txtTitle)
                txtTitle.text = "Toko tidak ditemukan"
                rvMerchant.isVisible = !isEmpty

                val errorState = loadStates.refresh as? LoadState.Error
                    ?: loadStates.append as? LoadState.Error
                    ?: loadStates.prepend as? LoadState.Error

                if (errorState != null) {
                    iclEmptyState.root.visibility = View.VISIBLE
                    val txtTitle = iclEmptyState.root.findViewById<TextView>(R.id.txtTitle)
                    txtTitle.text = "Toko tidak ditemukan"
                    rvMerchant.visibility = View.GONE
                    Toast.makeText(
                        requireContext(),
                        "Error: ${errorState.error.message}",
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
        }
    }

    private fun setupRecyclerView() = with(binding) {
        rvMerchant.layoutManager = LinearLayoutManager(requireContext())
        rvMerchant.adapter = merchantAdapter.withLoadStateHeaderAndFooter(
            header = LoadStateAdapter { merchantAdapter.retry() },
            footer = LoadStateAdapter { merchantAdapter.retry() }
        )
        lifecycleScope.launch {
            viewModel.merchantResponse.collectLatest {
                merchantAdapter.submitData(it)
                loading = false
            }
        }
    }

    private fun startStopwatch(createdAt: String) = with(binding) {
        val inputFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale("id"))
        inputFormat.timeZone = TimeZone.getTimeZone("UTC")
        val startDateUTC: Date = inputFormat.parse(createdAt)!!

        val calendar = Calendar.getInstance()
        calendar.time = startDateUTC
        calendar.add(Calendar.HOUR_OF_DAY, 7)
        val startDateWIB = calendar.time

        stopwatchRunnable?.let { runnable ->
            stopwatchHandler?.removeCallbacks(runnable)
        }

        stopwatchHandler = Handler(Looper.getMainLooper())

        stopwatchRunnable = object : Runnable {
            override fun run() {
                val now = Date()
                val diff = now.time - startDateWIB.time

                val hours = diff / (1000 * 60 * 60)
                val minutes = (diff / (1000 * 60) % 60)
                val seconds = (diff / 1000 % 60)

                txtWorkingHours.text = String.format("%02d:%02d:%02d", hours, minutes, seconds)

                stopwatchHandler?.postDelayed(this, 1000)
            }
        }

        stopwatchHandler?.post(stopwatchRunnable!!)
    }

}