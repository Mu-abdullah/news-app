import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/new_cubit.dart';
import 'package:news_app/shared/cubit/state.dart';
import 'package:news_app/shared/network/remote/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/new_layouts.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  // bool? isDark = CacheHelper.getBool(key: "isDark");

  BlocOverrides.runZoned(
    ()  {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // final bool? isDark;

  // MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getAppMode()
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getScience()
            ..getSports(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      systemNavigationBarIconBrightness: Brightness.dark),
                  color: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(
                    color: Colors.deepOrange,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                elevation: 25,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black87,
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey,
                      systemNavigationBarIconBrightness: Brightness.light),
                  color: Colors.black87,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(
                    color: Colors.deepOrange,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 25,
                backgroundColor: Colors.black87,
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            themeMode:AppCubit.get(context).themeMode,
            home: NewsLayouts(),
          );
        },
      ),
    );
  }
}
