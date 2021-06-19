import 'package:flutter/material.dart';

abstract class HomeEvent {}

class InitEvent extends HomeEvent {
  InitEvent();
}

class SignUpButtonPressedEvent extends HomeEvent {
  String? email, password, dob, gender, username, phone;

  BuildContext? context;

  SignUpButtonPressedEvent(
      {this.context,
      this.email,
      this.password,
      this.dob,
      this.gender,
      this.phone,
      this.username});
}
