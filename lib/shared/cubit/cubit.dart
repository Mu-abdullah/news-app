import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/businuss_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/state.dart';
import 'package:news_app/shared/network/remote/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
  ];
  List<String> titles = ["Business", "Science", "Sport"];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sport",
    ),
  ];

  void changeNavBarItems(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    } else if (index == 2) {
      getSports();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'dfb318ea7f624d80b1ef0d5577f3e8ca',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'dfb318ea7f624d80b1ef0d5577f3e8ca',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
    emit(NewsLoadingState());
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'dfb318ea7f624d80b1ef0d5577f3e8ca',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  // bool isDark = false;
  // ThemeMode theme = ThemeMode.dark;
  //
  // void changeAppMode({bool? fromShared}) {
  //   if (fromShared != null) {
  //     isDark = CacheHelper.sharedPreferences!.getBool('isDark')!;
  //     emit(NewsChangeAppModeState());
  //   } else {
  //     isDark = !isDark;
  //     CacheHelper.putBool(key: "isDark", value: isDark).then((value) {
  //       emit(NewsChangeAppModeState());
  //     });
  //   }
  // }
  //
  // void getAppMode(){
  //   isDark = CacheHelper.sharedPreferences!.getBool('isDark')!;
  //   theme = (isDark)?  ThemeMode.dark : ThemeMode.light;
  //   emit(NewsChangeAppModeState());
  // }


  List<dynamic> search = [];

  void getSearch(String value) {
    search=[];
    emit(NewsLoadingState());
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': 'dfb318ea7f624d80b1ef0d5577f3e8ca',
        },
      ).then((value) {
        search = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });

  }
}
