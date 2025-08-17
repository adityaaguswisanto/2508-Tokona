package com.adityaagusw.tokona.presentation.product

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.adityaagusw.tokona.R
import com.adityaagusw.tokona.core.models.product.Product
import com.adityaagusw.tokona.core.helpers.toRupiah
import com.adityaagusw.tokona.databinding.ProductItemBinding
import com.adityaagusw.tokona.databinding.ProductShimmerBinding
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.RequestOptions

class ProductAdapter(
    private var items: List<Product?> = emptyList(),
    private val onItemClick: ((Product) -> Unit)? = null,
    private val onQrCodeClick: ((Product) -> Unit)? = null
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private val TYPE_SHIMMER = 0
    private val TYPE_DATA = 1

    inner class ProductViewHolder(val binding: ProductItemBinding) :
        RecyclerView.ViewHolder(binding.root)

    inner class ShimmerViewHolder(val binding: ProductShimmerBinding) :
        RecyclerView.ViewHolder(binding.root)

    override fun getItemViewType(position: Int): Int {
        return if (items[position] == null) TYPE_SHIMMER else TYPE_DATA
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return if (viewType == TYPE_SHIMMER) {
            val binding = ProductShimmerBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
            ShimmerViewHolder(binding)
        } else {
            val binding = ProductItemBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
            ProductViewHolder(binding)
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ProductViewHolder) {
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
                txtName.text = item.name
                txtDescription.text = item.description
                txtPrice.text = item.price?.toRupiah()

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

    fun updateData(newItems: List<Product>) {
        items = newItems
        notifyDataSetChanged()
    }
}
