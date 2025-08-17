import 'package:tokona/packages/packages.dart';

class MenuModal extends StatelessWidget {
  final ProductData productData;
  final ProductBloc productBloc;
  final PromoBloc promoBloc;
  final Function() goTabPromo;
  final InventoryArgument inventoryArgument;

  const MenuModal({
    super.key,
    required this.productData,
    required this.productBloc,
    required this.promoBloc,
    required this.goTabPromo,
    required this.inventoryArgument,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        16.r,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pilih Menu",
                style: Texts.bold(
                  fontSize: 16.sp,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => Navigations.back(context),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          MenuItem(
            title: "Detail Produk",
            description: "Lihat nama, deskripsi, dan status ketersediaan.",
            onTap: () {
              Navigations.back(context);
              showModalBottomSheet(
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
                builder: (context) => ProductModal(
                  productData: productData,
                  productBloc: productBloc,
                  inventoryArgument: inventoryArgument,
                ),
              );
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          MenuItem(
            title: "Buat Promo",
            description: "Tentukan harga diskon dan periode berlaku.",
            onTap: () {
              Navigations.back(context);
              showModalBottomSheet(
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
                builder: (context) => PromoModal(
                  productData: productData,
                  promoBloc: promoBloc,
                  goTabPromo: goTabPromo,
                  inventoryArgument: inventoryArgument,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
