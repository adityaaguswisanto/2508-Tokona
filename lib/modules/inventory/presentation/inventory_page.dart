import 'package:tokona/packages/packages.dart';

class InventoryPage extends StatefulWidget {
  static const String routeName = "/inventory";

  final InventoryArgument inventoryArgument;

  const InventoryPage({
    super.key,
    required this.inventoryArgument,
  });

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>
    with SingleTickerProviderStateMixin {
  final productBloc = locator<ProductBloc>();
  final promoBloc = locator<PromoBloc>();

  final search = TextEditingController();
  late TabController tabController;

  MerchantData? merchantData;

  bool showSearch = false;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    merchantData = widget.inventoryArgument.merchantData;
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        tabIndex = tabController.index;
      }
    });
  }

  @override
  void dispose() {
    search.dispose();
    tabController.dispose();
    super.dispose();
  }

  Future<void> goTabPromo() async {
    await Future.delayed(
      const Duration(
        milliseconds: 750,
      ),
    );
    promoBloc.add(
      PromoRefreshed(
        merchantId: widget.inventoryArgument.merchantData?.id,
        search: "",
      ),
    );
    setState(() {
      tabController.index = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white200,
      body: SafeArea(
        child: Column(
          children: [
            InventoryAppbar(
              merchantData: merchantData,
              onTap: () => setState(() {
                showSearch = true;
              }),
            ),
            if (showSearch)
              InventorySearch(
                search: search,
                onFieldSubmitted: (value) {
                  if (tabIndex == 0) {
                    productBloc.add(
                      ProductRefreshed(
                        merchantId: widget.inventoryArgument.merchantData?.id,
                        search: value,
                      ),
                    );
                  } else {
                    promoBloc.add(
                      PromoRefreshed(
                        merchantId: widget.inventoryArgument.merchantData?.id,
                        search: value,
                      ),
                    );
                  }
                },
              ),
            SizedBox(
              height: 16.h,
            ),
            InventoryTabbar(
              tabController: tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ProductPage(
                    inventoryArgument: widget.inventoryArgument,
                    productBloc: productBloc,
                    promoBloc: promoBloc,
                    goTabPromo: () => goTabPromo(),
                  ),
                  PromoPage(
                    inventoryArgument: widget.inventoryArgument,
                    promoBloc: promoBloc,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
