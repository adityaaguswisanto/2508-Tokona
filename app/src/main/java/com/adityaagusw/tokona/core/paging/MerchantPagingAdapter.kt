package com.adityaagusw.tokona.core.paging

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.adityaagusw.tokona.core.helpers.toFormattedDate
import com.adityaagusw.tokona.core.models.merchant.Merchant
import com.adityaagusw.tokona.databinding.MerchantItemBinding

class MerchantPagingAdapter(
    private val onItemClick: ((Merchant) -> Unit)? = null
) : PagingDataAdapter<Merchant, RecyclerView.ViewHolder>(DiffCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val binding = MerchantItemBinding.inflate(
            LayoutInflater.from(parent.context),
            parent,
            false
        )
        return MerchantViewHolder(binding, onItemClick)
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is MerchantViewHolder) {
            getItem(position)?.let { holder.bind(it) }
        }
    }

    inner class MerchantViewHolder(
        private val binding: MerchantItemBinding,
        private val onItemClick: ((Merchant) -> Unit)?
    ) : RecyclerView.ViewHolder(binding.root) {
        fun bind(item: Merchant) = with(binding) {
            txtCode.text = item.code
            txtMerchant.text = item.name
            txtAddress.text = item.address
            txtDate.text = item.createdAt?.toFormattedDate()

            root.setOnClickListener {
                onItemClick?.invoke(item)
            }
        }
    }

    class DiffCallback : DiffUtil.ItemCallback<Merchant>() {
        override fun areItemsTheSame(oldItem: Merchant, newItem: Merchant) =
            oldItem.id == newItem.id

        override fun areContentsTheSame(oldItem: Merchant, newItem: Merchant) = oldItem == newItem
    }
}
