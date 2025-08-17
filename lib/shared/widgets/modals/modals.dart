import 'package:tokona/packages/packages.dart';

class Modals extends StatelessWidget {
  final bool loading;
  final String title;
  final List<Widget> children;

  const Modals({
    super.key,
    required this.loading,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
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
                onPressed: loading ? null : () => Navigations.back(context),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: black,
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }
}
