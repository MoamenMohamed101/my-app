import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/layout/news_app/Cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/social_app/cubit/states.dart';
import 'package:first_app/layout/social_app/social_layout.dart';
import 'package:first_app/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:first_app/shared/bloc_obcerved.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:first_app/shared/network/remote/cash_helper.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:first_app/shared/styles/Themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/social_app/cubit/cubit.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  Diohelper.inti();
  await CashHelper.inti();
  Widget? widget;
  bool? isDark = CashHelper.getdata(key: 'isDark');
  //bool? onBoarding = CashHelper.getdata(key: 'onBoarding');
  //token = CashHelper.getdata(key: 'token');
  uId = CashHelper.getdata(key: 'uId');
  //print(token);
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = const ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = const OnBoardingScreen();
  // }
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(
    MyApp(
      isDark: isDark,
      startwidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startwidget;

  MyApp({this.isDark, this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getbusiness()
              ..getScience()
              ..getSports()),
        BlocProvider(
          create: (BuildContext context) =>
              Apployout()..changeApptheme(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              SocialCubit(SocialInitialStates)..getUserData(),
        ),
      ],
      child: BlocConsumer<Apployout, Applayoutstates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) => MaterialApp(
            theme: lighttheme,
            // darkTheme: darktheme,
            // themeMode: Apployout.get(context).isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startwidget),
      ),
    );
  }
}
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
//fontSize: 20, fontWeight: FontWeight.bold
//https://newsapi.org/v2/everything?q=tesla&apiKey=c791f2ce637147d2aa85013679d636f1
// allow read, write: if false;