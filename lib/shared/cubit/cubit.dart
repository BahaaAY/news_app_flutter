import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/modules/business_screen.dart';
import 'package:news_app_flutter/modules/science_screen.dart';
import 'package:news_app_flutter/modules/settings_screen.dart';
import 'package:news_app_flutter/modules/sports_screen.dart';
import 'package:news_app_flutter/shared/constants.dart';
import 'package:news_app_flutter/shared/cubit/states.dart';
import 'package:news_app_flutter/shared/network/local/cache_helper.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;
  List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_basketball_rounded), label: 'Sports'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingsScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
    if (index == 0 && businessNews.isEmpty) {
      getBusinessNews();
    }
    if (index == 1 && scienceNews.isEmpty) {
      getScienceNews();
    }
    if (index == 2 && sportsNews.isEmpty) {
      getSportsNews();
    }
  }

  List businessNews = [];
  List sportsNews = [];
  List scienceNews = [];

  void getBusinessNews() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '${apiKey}',
      },
    ).then((value) {
      businessNews = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
      print(businessNews[0]['author'].toString());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getScienceNews() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '${apiKey}',
      },
    ).then((value) {
      scienceNews = value.data['articles'];
      emit(NewsGetScienceSuccessState());
      print(scienceNews[0]['author'].toString());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSportsNews() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '${apiKey}',
      },
    ).then((value) {
      sportsNews = value.data['articles'];
      emit(NewsGetSportsSuccessState());
      print(sportsNews[0]['author'].toString());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List searchNews = [];

  void getSearchNews({required String? query}) {
    if (query != null) {
      if (query.isNotEmpty) {
        print("Searching for : $query");
        emit(NewsGetSearchLoadingState());
        DioHelper.getData(
          url: "v2/everything",
          query: {
            'q': '$query',
            'apiKey': '${apiKey}',
          },
        ).then((value) {
          searchNews = value.data['articles'];
          emit(NewsGetSearchSuccessState());
          print(searchNews[0]['author'].toString());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSearchErrorState(error.toString()));
        });
      }
    }
  }

  bool isDark = false;

  void getMode() {
    isDark = CacheHelper.getDark();
    print("got Dark: $isDark");
  }

  void switchMode() async {
    isDark = !isDark;
    if (await CacheHelper.putDark(isDark: isDark)) {
      emit(NewsSwitchModeState());
    }
  }
}
