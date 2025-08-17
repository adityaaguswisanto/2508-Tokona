import 'package:tokona/packages/packages.dart';

class ProductItem extends StatelessWidget {
  final ProductData productData;
  final VoidCallback? onPressedQrCode;
  final VoidCallback? onPressedPick;

  const ProductItem({
    super.key,
    required this.productData,
    required this.onPressedQrCode,
    required this.onPressedPick,
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
        child: IntrinsicHeight(
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
                  imageUrl: productData.photo.toString(),
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
                                productData.name.toString(),
                                style: Texts.bold(
                                  fontSize: 14.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                productData.description.toString(),
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
                        Text(
                          Formatters.idr(
                            productData.price,
                          ),
                          style: Texts.bold(
                            fontSize: 14.sp,
                            color: green,
                          ),
                        ),
                        GestureDetector(
                          onTap: onPressedPick,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.w,
                              horizontal: 16.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                16.r,
                              ),
                              border: Border.all(
                                width: 1.w,
                                color: orange,
                              ),
                            ),
                            child: Text(
                              "Pilih",
                              style: Texts.medium(
                                color: orange,
                              ),
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
      ),
    );
  }
}
