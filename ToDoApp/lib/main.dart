import 'package:ToDoApp/styles/AppTheme.dart';
import 'package:flutter/material.dart';

import 'view/new_task_page.dart';
import 'view/to_do_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

AppTheme appThemObj=AppTheme();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: appThemObj.commonAppTheme(),
      home: ToDoListPage(),
    );
  }
}

