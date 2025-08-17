import 'package:tokona/packages/packages.dart';

class ProductPage extends StatefulWidget {
  final InventoryArgument inventoryArgument;
  final ProductBloc productBloc;
  final PromoBloc promoBloc;
  final Function() goTabPromo;

  const ProductPage({
    super.key,
    required this.inventoryArgument,
    required this.productBloc,
    required this.promoBloc,
    required this.goTabPromo,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productController = ScrollController();

  final search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    productController.removeListener(() {
      onScroll();
    });
    super.dispose();
  }

  @override
  void initState() {
    getProduct();
    productController.addListener(() {
      onScroll();
    });
    super.initState();
  }

  void onScroll() {
    if (isBottom()) getProduct();
  }

  bool isBottom() {
    if (!productController.hasClients) return false;
    final maxScroll = productController.position.maxScrollExtent;
    final currentScroll = productController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void getProduct() {
    widget.productBloc.add(
      ProductGetted(
        merchantId: widget.inventoryArgument.merchantData?.id,
        search: search.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: widget.productBloc,
      builder: (context, state) {
        switch (state.status) {
          case ProductResponse.loading:
            return const ProductShimmer();
          case ProductResponse.success:
            final listProductData = state.listProductData;
            final hasReachedMax = state.hasReachedMax;
            if (listProductData.isEmpty) {
              return const Emptys(
                iconData: Icons.production_quantity_limits,
                title: "Tidak ada data produk",
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                top: 16.w,
              ),
              controller: productController,
              itemCount: hasReachedMax
                  ? listProductData.length
                  : listProductData.length + 1,
              itemBuilder: (context, index) {
                if (index >= listProductData.length) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 16.h,
                      ),
                      child: Loadings(
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  );
                }
                final data = listProductData[index];
                return ProductItem(
                  productData: data,
                  onPressedQrCode: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: false,
                    isDismissible: false,
                    backgroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          20.r,
                        ),
                      ),
                    ),
                    builder: (context) => QrModal(
                      productData: data,
                      promoData: null,
                    ),
                  ),
                  onPressedPick: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: false,
                    isDismissible: false,
                    backgroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          20.r,
                        ),
                      ),
                    ),
                    builder: (context) => MenuModal(
                      productData: data,
                      productBloc: widget.productBloc,
                      promoBloc: widget.promoBloc,
                      goTabPromo: widget.goTabPromo,
                      inventoryArgument: widget.inventoryArgument,
                    ),
                  ),
                );
              },
            );
          case ProductResponse.offline:
            return const Offlines();
          case ProductResponse.failure:
            return Failures(
              title: state.errorMessage,
            );
        }
      },
    );
  }
}
