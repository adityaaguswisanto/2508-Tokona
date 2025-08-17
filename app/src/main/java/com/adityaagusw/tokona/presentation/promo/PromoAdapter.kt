package com.adityaagusw.tokona.presentation.promo

import android.graphics.Paint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.models.promo.Promo
import com.adityaagusw.tokona.core.helpers.toFormattedDate
import com.adityaagusw.tokona.core.helpers.toRupiah
import com.adityaagusw.tokona.databinding.PromoItemBinding
import com.adityaagusw.tokona.databinding.PromoShimmerBinding
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.RequestOptions

class PromoAdapter(
    private var items: List<Promo?> = emptyList(),
    private val onItemClick: ((Promo) -> Unit)? = null,
    private val onQrCodeClick: ((Promo) -> Unit)? = null
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private val TYPE_SHIMMER = 0
    private val TYPE_DATA = 1

    inner class PromoViewHolder(val binding: PromoItemBinding) :
        RecyclerView.ViewHolder(binding.root)

    inner class ShimmerViewHolder(val binding: PromoShimmerBinding) :
        RecyclerView.ViewHolder(binding.root)

    override fun getItemViewType(position: Int): Int {
        return if (items[position] == null) TYPE_SHIMMER else TYPE_DATA
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return if (viewType == TYPE_SHIMMER) {
            val binding = PromoShimmerBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
            ShimmerViewHolder(binding)
        } else {
            val binding = PromoItemBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
            PromoViewHolder(binding)
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is PromoViewHolder) {
            val item = items[position] ?: return
            holder.binding.apply {
                Glide.with(holder.itemView.context)
                    .load(item.photo)
                    .placeholder(R.drawable.ic_search)
                    .apply(
                        RequestOptions()
                            .transform(RoundedCorners(30))
                    )
                    .error(R.drawable.ic_close)
                    .diskCacheStrategy(DiskCacheStrategy.ALL)
                    .into(ivPhoto)
                txtEndDate.text = "${item.endDate?.toFormattedDate()} masa berlaku"
                txtName.text = item.name
                txtDescription.text = item.description
                txtDiscount.text = item.discount?.toRupiah()
                txtPrice.apply {
                    text = item.price?.toRupiah()
                    paintFlags = paintFlags or Paint.STRIKE_THRU_TEXT_FLAG
                }

                ivQrcode.setOnClickListener {
                    onQrCodeClick?.invoke(item)
                }

                btnView.setOnClickListener {
                    onItemClick?.invoke(item)
                }
            }
        }
    }

    override fun getItemCount(): Int = items.size

    fun showShimmer(count: Int = 5) {
        items = List(count) { null }
        notifyDataSetChanged()
    }

    fun updateData(newItems: List<Promo>) {
        items = newItems
        notifyDataSetChanged()
    }
}
