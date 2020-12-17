import 'dart:async';
import 'package:ToDoApp/bloc/to_do_list_bloc/to_do_list_event.dart';
import 'package:ToDoApp/bloc/to_do_list_bloc/to_do_list_state.dart';
import 'package:ToDoApp/helper/database_helper.dart';
import 'package:ToDoApp/model/task.dart';
import 'package:ToDoApp/view/new_task_page.dart';
import 'package:ToDoApp/view/to_do_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  ToDoListBloc(initialState) : super(ToDoListInitState());
  DatabaseHelper dbHelperObj = DatabaseHelper();
  List<Task> taskList = List();

//stream controller todo taask list
  final _taskListStreamController = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get taskListStream => _taskListStreamController.stream;
  StreamSink<List<Task>> get taskListSink {
    return _taskListStreamController.sink;
  }

  Function(List<Task>) get taskListChanged {
    return _taskListStreamController.sink.add;
  }

//stream controller for list size of todo task list
  final _listSizeStreamController = BehaviorSubject<int>();
  Stream<int> get listSizeStream => _listSizeStreamController.stream;
  StreamSink<int> get _listSizeSink => _listSizeStreamController.sink;
  Function(int) get listSizeChanged => _listSizeStreamController.sink.add;

  @override
  Stream<ToDoListState> mapEventToState(ToDoListEvent event) async* {
    //intializing the todo task list
    taskList = await dbHelperObj.getTasks();
    _taskListStreamController.value = taskList;
    //seting list size in listsize controller for handling list will we shown or not same for floating button
    _listSizeSink.add(_taskListStreamController.value.length);
    if (event is InitEvent) {
    } else if (event is CheckBoxChangedEvent) {
      updateCheckboxFlag(event.id, event.isDone);
      Navigator.push(
        event.context,
        MaterialPageRoute(builder: (context) => ToDoListPage()),
      );
    } else if (event is EditBtnEvent) {
      Navigator.push(
        event.context,
        MaterialPageRoute(builder: (context) => NewTaskPage(event.id)),
      );
    } else if (event is DeleteBtnEvent) {
      dbHelperObj.deleteTask(event.id);
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(builder: (context) => ToDoListPage()),
      );
    }
  }

  void dispose() {
    _listSizeStreamController.close();
    _taskListStreamController.close();
  }

//function handling checkbox
  void updateCheckboxFlag(int id, int isDone) {
    if (isDone == 1) {
      isDone = 0;
    } else if (isDone == 0) {
      isDone = 1;
    }
    dbHelperObj.updateTaskCheckBox(id, isDone);
  }
}
