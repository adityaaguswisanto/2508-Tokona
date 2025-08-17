import 'package:tokona/packages/packages.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        top: 16.w,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
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
                children: [
                  Shimmers(
                    width: 60.h,
                    height: 60.h,
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
                                children: [
                                  Shimmers(
                                    width: Sizes.width(context),
                                    height: 12.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Shimmers(
                                    width: Sizes.width(context),
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Shimmers(
                              width: 26.w,
                              height: 26.h,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Shimmers(
                              width: Sizes.width(context) * 0.2,
                              height: 12.h,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Shimmers(
                              width: Sizes.width(context) * 0.2,
                              height: 12.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmers(
                  width: Sizes.width(context) * 0.4,
                  height: 12.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Shimmers(
                  width: Sizes.width(context),
                  height: 12.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Shimmers(
                  width: Sizes.width(context) * 0.2,
                  height: 12.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Shimmers(
                  width: Sizes.width(context) * 0.3,
                  height: 12.h,
                ),
                */
            /*Row(
                  children: [
                    SvgPicture.asset(
                      ConstantsAssets.icDate,
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      Dates.formatDate(
                        merchantData.createdAt.toString(),
                      ),
                      style: Texts.medium(),
                    ),
                  ],
                )*/
            /*
              ],
            ),*/
          ),
        );
      },
    );
  }
}
