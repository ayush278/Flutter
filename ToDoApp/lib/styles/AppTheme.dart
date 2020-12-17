import 'package:flutter/material.dart';

class AppTheme {
  ThemeData commonAppTheme() {
  
    return ThemeData(
      textTheme: TextTheme(
      bodyText2:TextStyle(
        color:Colors.blue,
        fontWeight: FontWeight.bold
      ) ,
      bodyText1: TextStyle(
        color:Colors.blue
      )
    ),
    accentColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
       
        visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData checkboxTheme() {
    return ThemeData(
      unselectedWidgetColor: Colors.transparent,
    );
  }
}
