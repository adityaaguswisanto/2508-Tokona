import 'package:tokona/packages/packages.dart';

class InventoryAppbar extends StatelessWidget {
  final MerchantData? merchantData;
  final GestureTapCallback? onTap;

  const InventoryAppbar({
    super.key,
    required this.merchantData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: EdgeInsets.all(
        16.r,
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => Navigations.back(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: black,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchantData!.name.toString(),
                  style: Texts.bold(
                    fontSize: 14.sp,
                    color: black,
                  ),
                ),
                Text(
                  merchantData!.address.toString(),
                  style: Texts.medium(
                    color: black600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              ConstantsAssets.icSearch,
            ),
          ),
        ],
      ),
    );
  }
}
