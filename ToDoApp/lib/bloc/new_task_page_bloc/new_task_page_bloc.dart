import 'dart:async';
import 'package:ToDoApp/helper/database_helper.dart';
import 'package:ToDoApp/model/task.dart';
import 'package:ToDoApp/view/to_do_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'new_task_page_event.dart';
import 'new_task_page_state.dart';
import 'package:intl/intl.dart';

class NewTaskPageBloc extends Bloc<NewTaskPageEvent, NewTaskPageState> {
  NewTaskPageBloc(initialState) : super(NewTaskPageInitState());
  DatabaseHelper dbHelperObj = DatabaseHelper();

  final now = DateTime.now();
  String selectedDate;

  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  List<Task> taskList = List();

//stream controller for date
  final _selectedDateStreamController = BehaviorSubject<String>();
  Stream<String> get selectedDateStream => _selectedDateStreamController.stream;
  StreamSink<String> get _selectedDateSink =>
      _selectedDateStreamController.sink;
  Function(String) get selectedDateChanged =>
      _selectedDateStreamController.sink.add;

  @override
  Stream<NewTaskPageState> mapEventToState(NewTaskPageEvent event) async* {
    selectedDate = DateFormat('yMd').format(now);
    if (event is InitEvent) {
      //intializing date
      _selectedDateSink.add(selectedDate);
      if (event.id == 0) {
      } else {
        //getting todo task from list
        taskList = await dbHelperObj.getTodo(event.id);
        //intializing the title from todo task
        titleController.text = taskList[0].title;
        //intializing the discription from todo task
        discriptionController.text = taskList[0].description;
        //intializing date
        _selectedDateSink.add(taskList[0].date);
      }
    } else if (event is CheckBtnEvent) {
      if (event.id == 0) {
        //function inserting todo into tasklist
        dbHelperObj.insertTask(Task(
            title: titleController.text,
            description: discriptionController.text,
            date: selectedDate.toString(),
            isDone: 0));
      } else {
        //function  updating data in task list
        dbHelperObj.updateTaskTitleDis(event.id, titleController.text,
            discriptionController.text, selectedDate.toString());
      }
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(builder: (context) => ToDoListPage()),
      );
    }
  }

//Function picking date
  void selectDateEvent(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2015),
      lastDate: DateTime(2035),
    );
    if (picked != null && picked != selectedDate)
      _selectedDateSink.add(DateFormat('yMd').format(picked));
  }

  void dispose() {
    _selectedDateStreamController.close();
  }

}
