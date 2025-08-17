import 'package:tokona/packages/packages.dart';

class Routes {
  static Route<dynamic> g(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case InventoryPage.routeName:
        if (args is InventoryArgument) {
          return MaterialPageRoute(
            builder: (_) => InventoryPage(
              inventoryArgument: args,
            ),
          );
        }
        return notFoundPage();
      default:
        return notFoundPage();
    }
  }

  static Route<dynamic> notFoundPage() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Text(
              "Page Not found",
              style: Texts.medium(),
            ),
          ),
        );
      },
    );
  }
}
