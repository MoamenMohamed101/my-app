import 'package:bloc/bloc.dart';
import 'package:first_app/layout/todo_app/archive_tasks/archive_tasks_screen.dart';
import 'package:first_app/layout/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:first_app/layout/todo_app/tasks/new_tasks_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:first_app/shared/network/remote/cash_helper.dart';
import 'package:sqflite/sqflite.dart';

class Apployout extends Cubit<Applayoutstates> {
  Apployout() : super(InItialstateslayout());

  static Apployout get(context) => BlocProvider.of(context);
  int? intcurrent = 0;
  List tasks = [Newtasksscreen(), Donetasksscreen(), Archivetasksscreen()];
  List<String> names = ['Tasks', 'Done Tasks', 'Aechive Tasks'];
  void changenavigator(int index) {
    intcurrent = index;
    emit(AppchangeNavigatorbarstates());
  }

  List<Map> newlists = [];
  List<Map> donelists = [];
  List<Map> archivelists = [];
  Database? database;

  void createDatabase() {
    openDatabase(
      'todoapp.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getdatafromdatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabasestates());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabasestates());

        getdatafromdatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void updateData({
    @required String? status,
    @required int? id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getdatafromdatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    @required int? id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getdatafromdatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void getdatafromdatabase(database) {
    newlists = [];
    donelists = [];
    archivelists = [];
    emit(AppGetDataBaseloadingstates());
    database!.rawQuery('SELECT * from tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newlists.add(element);
        } else if (element['status'] == 'done') {
          donelists.add(element);
        } else {
          archivelists.add(element);
        }
      });
      emit(AppGetDataBasestates());
    });
  }

  bool? isBottomSheetShown = false;
  IconData? flotingicon = Icons.edit;
  void changeBottomSheetState(
      {@required bool? isshow, @required IconData? icon}) {
    isBottomSheetShown = isshow;
    flotingicon = icon;
    emit(AppChangeButtomtates());
  }

  bool isDark = false;

  void changeApptheme({bool? fromShared}) {
    if(fromShared != null){
      isDark = fromShared;
      emit(ThemeStates());
    }
    else{
      isDark = !isDark;
      CashHelper.putdata('isDark', isDark)!.then((value) {
        emit(ThemeStates());
      });
    }
  }
}
