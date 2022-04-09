import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/layout/news_app/Cubit/states.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';

import '../../../modules/news_app/Business/business.dart';
import '../../../modules/news_app/science/science.dart';
import '../../../modules/news_app/sports/sports.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomnav = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
  ];
  change(int index) {
    currentindex = index;
    emit(ChangeBottomNavStates());
  }

  List<Widget> screens = const [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  List<dynamic> business = [];
  void getbusiness() {
    emit(Newgetbusinessloading());
    Diohelper.getdataa(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': 'bb766d6625914b95bf1107ac8eef63de',
    })!
        .then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(Newgetbusinesssuceere());
    }).catchError((error) {
      print(error.toString());
      emit(
        Newgetbusinesserror(
          error: error.toString(),
        ),
      );
    });
  }

  List<dynamic> Science = [];
  void getScience() {
    emit(NewgetScienceloading());
    Diohelper.getdataa(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Science',
      'apikey': 'bb766d6625914b95bf1107ac8eef63de',
    })!
        .then((value) {
      //print(value.data['articles'][0]['title']);
      Science = value.data['articles'];
      print(Science[0]['title']);
      emit(NewgetSciencesuceere());
    }).catchError((error) {
      print(error.toString());
      emit(
        NewgetScienceerror(
          error: error.toString(),
        ),
      );
    });
  }

  List<dynamic> Sports = [];
  void getSports() {
    emit(NewgetSportsloading());
    Diohelper.getdataa(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Sports',
      'apikey': 'bb766d6625914b95bf1107ac8eef63de',
    })!
        .then((value) {
      //print(value.data['articles'][0]['title']);
      Sports = value.data['articles'];
      print(Sports[0]['title']);
      emit(NewgetSportssuceere());
    }).catchError((error) {
      print(error.toString());
      emit(
        NewgetSportserror(
          error: error.toString(),
        ),
      );
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewgetSearcheloading());
    Diohelper.getdataa(path: 'v2/everything', query: {
      'q': '$value',
      'apikey': 'bb766d6625914b95bf1107ac8eef63de',
    })!
        .then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewgetSearchesuceere());
    }).catchError((error) {
      print(error.toString());
      emit(
        NewgetSearcheerror(error: error.toString()),
      );
    });
  }
}
