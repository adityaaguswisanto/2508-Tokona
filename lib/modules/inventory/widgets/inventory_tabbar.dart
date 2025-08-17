import 'package:tokona/packages/packages.dart';

class InventoryTabbar extends StatelessWidget {
  final TabController tabController;

  const InventoryTabbar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(
          6.r,
        ),
      ),
      child: Container(
        height: 30.h,
        margin: EdgeInsets.symmetric(
          horizontal: 16.r,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.r,
            ),
          ),
          color: white,
        ),
        child: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: orange,
            border: Border.all(
              color: orange.withValues(
                alpha: 0.2,
              ),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                8.r,
              ),
            ),
          ),
          labelColor: white,
          labelStyle: Texts.bold(),
          unselectedLabelColor: orange,
          unselectedLabelStyle: Texts.medium(
            color: orange,
          ),
          tabs: const [
            Tab(
              child: Text(
                "Product",
              ),
            ),
            Tab(
              child: Text(
                "Promo",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
