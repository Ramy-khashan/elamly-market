import 'package:elamlymarket/modules/login/view/login_screen.dart';
import 'package:elamlymarket/modules/navigator_bar/view/navigator_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/app/app_cubit.dart';
import 'config/theme/theme.dart';
import 'generated/l10n.dart';
import 'core/utils/service_locator.dart';
import 'modules/explore/controller/explore_cubit.dart';
import 'modules/home/controller/home_cubit.dart';
import 'modules/on_boarding/view/on_boarding_screen.dart';
import 'modules/search/controller/search_cubit.dart';

class Market extends StatelessWidget {
  const Market({super.key});
  static GlobalKey<NavigatorState> navigatorKet = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => sl<HomeCubit>()
            ..getAds()
            ..getProductOnOffer()
            ..getProductMostSelling(),
        ),
        BlocProvider<AppCubit>(
          lazy: false,
          create: (context) => AppCubit()
            ..getInitial()
            ..initNotification()
            ..getSavedThemeMode(),
        ),
        BlocProvider<ExploreCubit>(
          create: (_) => sl<ExploreCubit>()..getCategories(),
        ),
        BlocProvider<SearchCubit>(
          lazy: false,
          create: (_) => SearchCubit()..getProduct(),
        )
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit controller = AppCubit.get(context);
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  navigatorKey: navigatorKet,
                  darkTheme: darkTheme,
                  themeMode: controller.isDarkTheme == null
                      ? ThemeMode.system
                      : controller.isDarkTheme!
                          ? ThemeMode.dark
                          : ThemeMode.light,
                  locale: Locale('en'),
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  home: controller.onBoarding == "true"
                      ? ((controller.isActive == "true" ||
                              controller.isActive == null
                          ? NavigatorBarScreen()
                          : LoginScreen()))
                      : OnBoardingScreen(),
                );
              });
        },
      ),
    );
  }
}
