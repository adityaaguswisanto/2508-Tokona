import 'package:tokona/packages/packages.dart';

class Providers {
  MultiBlocProvider p({
    required Widget? child,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<MerchantBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<AttendancesBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<ProductBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<PromoBloc>(),
        ),
      ],
      child: child!,
    );
  }
}
