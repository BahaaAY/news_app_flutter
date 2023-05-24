import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_flutter/layout/home_layout.dart';
import 'package:news_app_flutter/modules/webview_screen.dart';
import 'package:news_app_flutter/shared/cubit/cubit.dart';
import 'package:news_app_flutter/shared/cubit/states.dart';
import 'package:news_app_flutter/shared/network/local/cache_helper.dart';
import 'package:news_app_flutter/shared/network/remote/dio_helper.dart';

import 'shared/cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusinessNews(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context)..getMode();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              textTheme: TextTheme(
                  bodyLarge: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              )),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  size: 28,
                  color: Colors.black,
                ),
                actionsIconTheme: IconThemeData(
                  size: 28,
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
              ),
              primarySwatch: Colors.deepOrange,
            ),
            darkTheme: ThemeData(
                textTheme: TextTheme(
                    bodyLarge: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                )),
                scaffoldBackgroundColor: HexColor('#121212'),
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                    size: 28,
                    color: Colors.white,
                  ),
                  actionsIconTheme: IconThemeData(
                    size: 28,
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: HexColor('#121212'),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('#121212'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  elevation: 0,
                ),
                primarySwatch: Colors.deepOrange,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.deepOrangeAccent,
                  backgroundColor: HexColor('#121212'),
                )),
            home: HomeLayout(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
