import 'package:tokona/packages/packages.dart';

class PromoModal extends StatefulWidget {
  final ProductData productData;
  final PromoBloc promoBloc;
  final Function() goTabPromo;
  final InventoryArgument inventoryArgument;

  const PromoModal({
    super.key,
    required this.productData,
    required this.promoBloc,
    required this.goTabPromo,
    required this.inventoryArgument,
  });

  @override
  State<PromoModal> createState() => _PromoModalState();
}

class _PromoModalState extends State<PromoModal> {
  final discount = TextEditingController();
  final endDate = TextEditingController();

  bool loading = false;

  DateTime? dateTime;

  @override
  void dispose() {
    discount.dispose();
    endDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.productData;
    final merchantId = data.merchantId;
    final productId = data.productId;
    final name = data.name;
    final description = data.description;
    final price = data.price;
    return BlocListener<PromoBloc, PromoState>(
      bloc: widget.promoBloc,
      listener: (context, state) {
        switch (state.status) {
          case PromoResponse.loading:
            setState(() {
              loading = true;
            });
            break;
          case PromoResponse.success:
            setState(() {
              loading = false;
            });
            Navigations.back(context);
            widget.goTabPromo();
            break;
          case PromoResponse.offline:
            break;
          case PromoResponse.failure:
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
        title: "Promo",
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
            "Harga Asal",
            style: Texts.regular(),
          ),
          Text(
            Formatters.idr(
              price,
            ),
            style: Texts.bold(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Harga Diskon",
            style: Texts.regular(),
          ),
          SizedBox(
            height: 8.h,
          ),
          PromoDiscount(
            discount: discount,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Tanggal Akhir Diskon",
            style: Texts.regular(),
          ),
          SizedBox(
            height: 8.h,
          ),
          PromoEndDate(
            endDate: endDate,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 2),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: orange,
                        onPrimary: white,
                        onSurface: black,
                      ),
                      dialogBackgroundColor: white,
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                dateTime = picked;
                endDate.text = Dates.formatDate(
                  dateTime.toString(),
                  format: "dd MMMM yyyy",
                );
              }
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          loading
              ? const Center(
                  child: Loadings(),
                )
              : SizedBox(
                  width: Sizes.width(context),
                  child: Buttons(
                    onPressed: () async {
                      String discounts = discount.text.replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );

                      if (discount.text.isEmpty) {
                        Toasts.regular("Harga diskon masih kosong");
                        return;
                      }
                      int? discountValue = int.tryParse(discounts) ?? 0;

                      if (discountValue >= price!) {
                        Toasts.regular(
                          "Harga diskon tidak boleh lebih besar dari harga produk",
                        );
                        return;
                      }

                      if (endDate.text.isEmpty) {
                        Toasts.regular("Tanggal akhir diskon masih kosong");
                        return;
                      }

                      final normalized = DateTime.utc(
                        dateTime!.year,
                        dateTime!.month,
                        dateTime!.day,
                      );

                      widget.promoBloc.add(
                        PromoSubmitted(
                          merchantId: merchantId,
                          productId: productId,
                          price: price,
                          discount: discountValue,
                          endDate: normalized.toIso8601String(),
                        ),
                      );
                    },
                    label: "Buat Promo",
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
