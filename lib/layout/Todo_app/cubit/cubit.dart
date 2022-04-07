import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/Todo_app/cubit/states.dart';
import 'package:todo_app/modules/Todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/Todo_app/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/Todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
   AppCubit() : super(AppInitialState()) ;

  AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'archived Tasks',
  ];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  void changeBottomNavBar({@required int index}){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSteetState());
  }

   Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase(){
    openDatabase(
        'todo.db',
        version: 1,

        onCreate: (database, version)  {
          print('database created');

          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error){
            print('Error When Creating Table ${error.toString()}');
          });

        },
        onOpen:(database){
          getDataFromDatabase(database);
          print('database opened');
        }
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }

  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element)
      {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if(element['status'] == 'done')
          doneTasks.add(element);
        else archivedTasks.add(element);
      });

      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    @required String status,
    @required int id,
  }) async
  {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpdatetDatabaseLoadingState());
    });
  }

  void deleteData({
    @required int id,
  }) async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseStatus());
    });
  }
}