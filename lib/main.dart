import 'package:tokona/packages/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

  init();

  await Envs().l(
    url: ".env",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Providers().p(
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          theme: ThemeData(
            primarySwatch: Colors.red,
            scaffoldBackgroundColor: white200,
            appBarTheme: const AppBarTheme(
              backgroundColor: transparent,
              elevation: 0,
            ),
          ),
          onGenerateRoute: Routes.g,
        ),
      ),
    );
  }
}
