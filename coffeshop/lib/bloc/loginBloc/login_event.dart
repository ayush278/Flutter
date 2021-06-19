import 'package:flutter/cupertino.dart';

abstract class LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {
  String? email, password;
  BuildContext context;
  LoginButtonPressedEvent(
    this.context, {
    this.email,
    this.password,
  });
}

class InitEvent extends LoginEvent {}

class FacebookButtonPressedEvent extends LoginEvent {
  BuildContext context;
  FacebookButtonPressedEvent(this.context);
}

class GoogleButtonPressedEvent extends LoginEvent {
  BuildContext context;
  GoogleButtonPressedEvent(this.context);
}
