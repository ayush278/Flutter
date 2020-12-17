import 'package:ToDoApp/bloc/new_task_page_bloc/new_task_page_bloc.dart';
import 'package:ToDoApp/bloc/new_task_page_bloc/new_task_page_event.dart';
import 'package:ToDoApp/bloc/new_task_page_bloc/new_task_page_state.dart';
import 'package:ToDoApp/helper/database_helper.dart';
import 'package:ToDoApp/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskPage extends StatefulWidget {
  final int id;
  NewTaskPage(this.id);
  @override
  _NewTaskPageState createState() => _NewTaskPageState(this.id);
}

class _NewTaskPageState extends State<NewTaskPage> {
  _NewTaskPageState(this.id);
  int id;

  Task task = Task();
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();

  DatabaseHelper dbHepler = DatabaseHelper();

  NewTaskPageBloc newTaskPageBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewTaskPageBloc>(
        create: (context) => NewTaskPageBloc(NewTaskPageSuccessfulState)
          ..add(InitEvent(this.id)),
        child: BlocBuilder<NewTaskPageBloc, NewTaskPageState>(
            builder: (BuildContext context, NewTaskPageState state) {
          if (state is NewTaskPageInitState) {
            newTaskPageBloc = BlocProvider.of<NewTaskPageBloc>(context);

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                  title: Text("New Task"),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.check_outlined),
                        onPressed: () async {
                          newTaskPageBloc.add(CheckBtnEvent(context, this.id));
                        }),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: bodySection(context),
                  ),
                ),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        }));
  }

  Widget bodySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 16, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection(context),
                    SizedBox(
                      height: 20,
                    ),
                    discriptionSection(context),
                    SizedBox(
                      height: 20,
                    ),
                    dateSection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleSection(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title"),
          TextFormField(
              controller: newTaskPageBloc.titleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
                isDense: true,
              )),
        ]);
  }

  Widget discriptionSection(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What to be done ?"),
          TextFormField(
              controller: newTaskPageBloc.discriptionController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
                isDense: true,
              )),
        ]);
  }

  Widget dateSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Due Date"),
        InkWell(
          onTap: () {
            newTaskPageBloc.selectDateEvent(context);
          },
          child: Container(
            child: Row(
              children: [
                StreamBuilder<String>(
                    stream: newTaskPageBloc.selectedDateStream,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      );
                    }),
                Icon(
                  Icons.date_range_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
