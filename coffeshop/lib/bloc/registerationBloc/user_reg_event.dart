import 'package:flutter/material.dart';

abstract class UserRegEvent {}

class SignUpButtonPressedEvent extends UserRegEvent {
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
