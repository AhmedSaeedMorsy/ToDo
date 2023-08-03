// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../../../app/resources/color_manager.dart';
import 'states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitState());
  static HomeBloc get(context) => BlocProvider.of(context);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEdit = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void openDrawer({required isEditOrAdd}) {
    isEdit = isEditOrAdd;
    emit(ChangeDrawerState());
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    } else {
      scaffoldKey.currentState!.openEndDrawer();
    }
  }

  Map taskItem = {};
  void getTask({required Map task}) {
    taskItem = task;
    editTask(task);
    emit(GetTaskItemState());
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void editTask(Map task) {
    titleController.text = task["title"];
    descriptionController.text = task["description"];
    date = task["date"];
    time = task["time"];
    emit(EditTaskState());
  }

  String date = "";
  void showDatePickerFunction({
    required BuildContext context,
  }) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 365,
        ),
      ),
    ).then((value) {
      date = DateFormat.MMMd().format(value!).toString();
      emit(SelectedDateState());
    });
  }

  String time = "";
  void showTimePickerFunction({
    required BuildContext context,
  }) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      time = "${value!.hour}:${value.minute}";
      emit(SelectedTimeState());
    });
  }

  List<Color> colorPicker = [
    ColorManager.pink,
    ColorManager.babyBlue,
    ColorManager.purple,
    ColorManager.darkBlue,
    ColorManager.lightGreen,
    ColorManager.grey,
    ColorManager.onion,
    ColorManager.mintGreen,
  ];
  int slectedColor = 0;
  void changeSelectedColor(int index) {
    slectedColor = index;
    emit(ChangeSelectedColorState());
  }

  late Database database;
  List<Map> tasks = [];

  void createDataBase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database, version) {
        database.execute(
            "create TABLE taskes (id integer primary key , title text ,description text,date text , time text ,color text)");
      },
      onOpen: (database) {
        getDataFromDataBase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertDataBase({
    required String title,
    required String date,
    required String description,
    required String color,
    required String time,
  }) async {
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              "insert into taskes (title , description , date , time , color) VALUES('$title','$description','$date', '$time' , '$color') ")
          .then((value) {
        emit(AppInsertDataintoDataBaseState());
        getDataFromDataBase(database);
      });
    });
  }

  void getDataFromDataBase(database) {
    tasks = [];
    database.rawQuery("select * from taskes").then((value) {
      value.forEach((element) {
        tasks.add(element);
      });

      emit(AppGetDataFromDataBaseState());
    });
  }

  void upDateDataBase({
    required String color,
    required int id,
    required String title,
    required String date,
    required String description,
    required String time,
  }) {
    database.rawUpdate("""UPDATE taskes 
SET color = ?, title = ?, date = ?, description = ?, time = ? 
WHERE id = ?""", [color, title, date, description, time, id]).then(
      (value) {
        getDataFromDataBase(database);
        emit(AppUpDateDatainDataBaseState());
      },
    );
  }

  void deleteFromDataBase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM taskes WHERE id = ?', [id]).then((value) {
      emit(AppDeleteDatainDataBaseState());
      getDataFromDataBase(database);
    });
  }
}
