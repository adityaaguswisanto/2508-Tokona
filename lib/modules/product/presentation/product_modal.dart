import 'package:tokona/packages/packages.dart';

class ProductModal extends StatefulWidget {
  final ProductData productData;
  final ProductBloc productBloc;
  final InventoryArgument inventoryArgument;

  const ProductModal({
    super.key,
    required this.productData,
    required this.productBloc,
    required this.inventoryArgument,
  });

  @override
  State<ProductModal> createState() => _ProductModalState();
}

class _ProductModalState extends State<ProductModal> {
  final productBloc = locator<ProductBloc>();

  bool isChecked = false;
  bool loading = false;

  @override
  void dispose() {
    productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.productData;
    final id = data.id;
    final merchantId = data.merchantId;
    final name = data.name;
    final description = data.description;
    return BlocListener<ProductBloc, ProductState>(
      bloc: productBloc,
      listener: (context, state) {
        switch (state.status) {
          case ProductResponse.loading:
            setState(() {
              loading = true;
            });
            break;
          case ProductResponse.success:
            setState(() {
              loading = false;
            });
            widget.productBloc.add(
              ProductRefreshed(
                merchantId: merchantId,
                search: "",
              ),
            );
            Navigations.back(context);
            break;
          case ProductResponse.offline:
            break;
          case ProductResponse.failure:
            setState(() {
              loading = false;
            });
            Toasts.regular(
              state.errorMessage,
            );
            break;
        }
      },
      child: Modals(
        loading: loading,
        title: "Product",
        children: [
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Nama Produk",
            style: Texts.regular(),
          ),
          Text(
            name.toString(),
            style: Texts.bold(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Deskripsi Produk",
            style: Texts.regular(),
          ),
          Text(
            description.toString(),
            style: Texts.bold(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Status",
            style: Texts.regular(),
          ),
          CheckboxListTile(
            title: Transform.translate(
              offset: const Offset(
                -12,
                0,
              ),
              child: Text(
                "Ya, barang tersedia",
                style: Texts.medium(),
              ),
            ),
            value: isChecked,
            contentPadding: EdgeInsets.zero,
            activeColor: orange,
            onChanged: (value) => setState(() {
              isChecked = value ?? false;
            }),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          SizedBox(
            height: 10.h,
          ),
          loading
              ? const Center(
                  child: Loadings(),
                )
              : SizedBox(
                  width: Sizes.width(context),
                  child: Buttons(
                    onPressed: () async {
                      if (!isChecked) {
                        Toasts.regular("Harus dipilih");
                        return;
                      }

                      productBloc.add(
                        ProductPutted(
                          id: id,
                          available: isChecked ? 1 : 0,
                        ),
                      );
                    },
                    label: "Update Data",
                    isSemiBold: true,
                  ),
                ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
