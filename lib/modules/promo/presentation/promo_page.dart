import 'package:tokona/packages/packages.dart';

class PromoPage extends StatefulWidget {
  final InventoryArgument inventoryArgument;
  final PromoBloc promoBloc;

  const PromoPage({
    super.key,
    required this.inventoryArgument,
    required this.promoBloc,
  });

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage>
    with AutomaticKeepAliveClientMixin<PromoPage> {
  final promoController = ScrollController();

  final search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    promoController.removeListener(() {
      onScroll();
    });
    super.dispose();
  }

  @override
  void initState() {
    getPromo();
    promoController.addListener(() {
      onScroll();
    });
    super.initState();
  }

  void onScroll() {
    if (isBottom()) getPromo();
  }

  bool isBottom() {
    if (!promoController.hasClients) return false;
    final maxScroll = promoController.position.maxScrollExtent;
    final currentScroll = promoController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void getPromo() {
    widget.promoBloc.add(
      PromoGetted(
        merchantId: widget.inventoryArgument.merchantData?.id,
        search: search.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PromoBloc, PromoState>(
      bloc: widget.promoBloc,
      builder: (context, state) {
        switch (state.status) {
          case PromoResponse.loading:
            return const SizedBox.shrink();
          case PromoResponse.success:
            final listPromoData = state.listPromoData;
            final hasReachedMax = state.hasReachedMax;
            if (listPromoData.isEmpty) {
              return const Emptys(
                iconData: Icons.discount,
                title: "Tidak ada data promo",
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                top: 16.w,
              ),
              controller: promoController,
              itemCount: hasReachedMax
                  ? listPromoData.length
                  : listPromoData.length + 1,
              itemBuilder: (context, index) {
                if (index >= listPromoData.length) {
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
                final data = listPromoData[index];
                return PromoItem(
                  promoData: data,
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
                      productData: null,
                      promoData: data,
                    ),
                  ),
                );
              },
            );
          case PromoResponse.offline:
            return const Offlines();
          case PromoResponse.failure:
            return Failures(
              title: state.errorMessage,
            );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
