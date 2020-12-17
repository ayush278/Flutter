import 'package:ToDoApp/bloc/to_do_list_bloc/to_do_list_bloc.dart';
import 'package:ToDoApp/bloc/to_do_list_bloc/to_do_list_event.dart';
import 'package:ToDoApp/bloc/to_do_list_bloc/to_do_list_state.dart';
import 'package:ToDoApp/styles/AppTheme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDoApp/helper/database_helper.dart';
import 'package:ToDoApp/model/task.dart';
import 'package:ToDoApp/view/new_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<Task> todoList = List();

  ToDoListBloc toDoListBloc;

  AppTheme appThemObj = AppTheme();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoListBloc>(
        create: (context) =>
            ToDoListBloc(ToDoListSuccessfulState)..add(InitEvent()),
        child: BlocBuilder<ToDoListBloc, ToDoListState>(
            builder: (BuildContext context, ToDoListState state) {
          if (state is ToDoListInitState) {
            toDoListBloc = BlocProvider.of<ToDoListBloc>(context);
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("ToDo App"),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewTaskPage(0)),
                            );
                          }),
                    ],
                  ),
                  body: SingleChildScrollView(child: bodySection(context)),
                  floatingActionButton: floatingBtnSection(context)),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        }));
  }

  Widget bodySection(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: StreamBuilder<int>(
          stream: toDoListBloc.listSizeStream,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                snapshot.data == 0
                    ? nothingToDoIconSection(context)
                    : todoListView(context)
              ],
            );
          }),
    );
  }

  Widget nothingToDoIconSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: SvgPicture.asset("assets/images/hammock.svg")),
        Center(child: Text("Nothing to do"))
      ],
    );
  }

  Widget todoListView(BuildContext context) {
    return Container(
      child: StreamBuilder<List<Task>>(
          stream: toDoListBloc.taskListStream,
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {});
                              toDoListBloc.add(CheckBoxChangedEvent(
                                  id: snapshot.data[index].id,
                                  isDone: snapshot.data[index].isDone,
                                  context: context));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: snapshot.data[index].isDone == 1
                                      ? Icon(
                                          Icons.check,
                                          size: 25.0,
                                          color: Colors.red,
                                        )
                                      : Container(
                                          width: 25,
                                          height: 25,
                                        )),
                            ),
                          ),
                          Column(
                            children: [
                              Text(snapshot.data[index].title),
                              Text(snapshot.data[index].description)
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    toDoListBloc.add(EditBtnEvent(
                                        context: context,
                                        id: snapshot.data[index].id));
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    toDoListBloc.add(DeleteBtnEvent(
                                        context: context,
                                        id: snapshot.data[index].id));
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Widget floatingBtnSection(BuildContext context) {
    return Container(
      child: StreamBuilder<int>(
          stream: toDoListBloc.listSizeStream,
          builder: (context, snapshot) {
            return snapshot.data == 0
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NewTaskPage(0)),
                      );
                    },
                    child: Icon(Icons.add),
                  )
                : Container();
          }),
    );
  }
}
