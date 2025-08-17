import 'package:tokona/packages/packages.dart';

class PromoItem extends StatelessWidget {
  final PromoData promoData;
  final VoidCallback? onPressedQrCode;

  const PromoItem({
    super.key,
    required this.promoData,
    required this.onPressedQrCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      child: Cards(
        elevation: 0,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.r,
                      ),
                    ),
                    child: CachedNetworkImage(
                      width: 70.w,
                      height: 70.h,
                      imageUrl: promoData.photo.toString(),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => SizedBox(
                        width: 70.w,
                        height: 70.h,
                        child: const Icon(
                          Icons.broken_image,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    promoData.name.toString(),
                                    style: Texts.bold(
                                      fontSize: 14.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    promoData.description.toString(),
                                    style: Texts.regular(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: onPressedQrCode,
                              icon: const Icon(
                                Icons.qr_code,
                                size: 30,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    Formatters.idr(
                                      promoData.discount,
                                    ),
                                    style: Texts.bold(
                                      fontSize: 14.sp,
                                      color: green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      Formatters.idr(
                                        promoData.price,
                                      ),
                                      style:
                                          Texts.regular(
                                            fontSize: 10.sp,
                                          ).copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2,
                                            decorationColor: black,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 1.w,
                                horizontal: 16.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                color: red,
                              ),
                              child: Text(
                                "Promo",
                                style: Texts.medium(
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${Dates.formatDate(promoData.endDate.toString(), format: "dd MMMM yyyy")} masa berlaku",
                style: Texts.regular(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
