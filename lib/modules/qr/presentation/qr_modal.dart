import 'package:tokona/packages/packages.dart';

class QrModal extends StatefulWidget {
  final ProductData? productData;
  final PromoData? promoData;

  const QrModal({
    super.key,
    required this.productData,
    required this.promoData,
  });

  @override
  State<QrModal> createState() => _QrModalState();
}

class _QrModalState extends State<QrModal> {
  @override
  Widget build(BuildContext context) {
    final code = widget.productData?.code ?? widget.promoData?.code;
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
                "Qr Code",
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
          Align(
            alignment: Alignment.topCenter,
            child: QrImageView(
              data: code.toString(),
              version: QrVersions.auto,
              size: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
