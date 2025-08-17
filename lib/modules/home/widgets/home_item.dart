import 'package:tokona/packages/packages.dart';

class HomeItem extends StatelessWidget {
  final MerchantData merchantData;

  const HomeItem({
    super.key,
    required this.merchantData,
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
        onTap: () => Navigations.go(
          context,
          InventoryPage.routeName,
          arguments: InventoryArgument(
            merchantData: merchantData,
          ),
        ),
        withRipple: true,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              merchantData.code.toString(),
              style: Texts.bold(
                fontSize: 14.sp,
                color: orange,
                letterSpacing: 4,
              ),
            ),
            Text(
              merchantData.name.toString(),
              style: Texts.bold(
                fontSize: 14.sp,
              ),
            ),
            Text(
              merchantData.address.toString(),
              style: Texts.regular(),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
