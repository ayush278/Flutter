import 'package:flutter/material.dart';

abstract class CartEvent {}

class InitEvent extends CartEvent {
  InitEvent();
}

class SignUpButtonPressedEvent extends CartEvent {
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
