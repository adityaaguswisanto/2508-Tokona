import 'package:tokona/packages/packages.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              ConstantsAssets.imgLogoWhite,
              width: 80.w,
              height: 80.h,
            ),
            const Spacer(),
            Text(
              "Powered by Aditya Agus Wisanto",
              style: Texts.medium(
                color: white,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await Secures().getToken();
    if (!mounted) return;
    Navigations.goRemoveUntil(
      context,
      token.isEmpty ? LoginPage.routeName : HomePage.routeName,
    );
  }
}
