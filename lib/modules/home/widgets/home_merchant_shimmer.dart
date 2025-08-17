import 'package:tokona/packages/packages.dart';

class HomeMerchantShimmer extends StatelessWidget {
  const HomeMerchantShimmer({super.key});

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
            child: Column(
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
              ],
            ),
          ),
        );
      },
    );
  }
}
