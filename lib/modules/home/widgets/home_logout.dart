import 'package:tokona/packages/packages.dart';

class HomeLogout extends StatelessWidget {
  const HomeLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
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
        builder: (context) => Padding(
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
                    "Logout",
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
              Text(
                "Apakah kamu yakin ingin keluar?",
                style: Texts.regular(),
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: Sizes.width(context),
                child: Buttons(
                  onPressed: () async {
                    await Secures().clearSession();
                    if (!context.mounted) return;
                    Navigations.goRemoveUntil(
                      context,
                      LoginPage.routeName,
                    );
                  },
                  label: "Ya, keluar",
                  isSemiBold: true,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            ConstantsAssets.icLogout,
            width: 16.w,
            height: 16.h,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            "Logout",
            style: Texts.medium(
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}
