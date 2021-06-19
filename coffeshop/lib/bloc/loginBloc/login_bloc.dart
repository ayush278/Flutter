import 'package:bloc/bloc.dart';
import 'package:coffeshop/repository/auth_repo.dart';
import 'package:coffeshop/view/loginview.dart';
import 'package:coffeshop/view_controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late AuthRepo authRepo;
  late UserController userController;

  final _emailStreamController = BehaviorSubject<String>();
  Stream<String> get emailStream => _emailStreamController.stream;
  StreamSink<String> get emailSink => _emailStreamController.sink;
  Function(String) get emailChanged => _emailStreamController.sink.add;

  void dispose() {
    _emailStreamController.close();
  }

  LoginBloc() : super(LoginInitialState()) {
    authRepo = AuthRepo();
    userController = UserController();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      try {
        yield LoginLoadingState();

        await userController.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        yield LoginSuccessfulState();
      } catch (e) {
        Navigator.of(event.context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return CustomAlertDialog(event.context);
            }));
      }
    } else if (event is FacebookButtonPressedEvent) {
      try {
        yield LoginLoadingState();
        await userController.signInWithFacebook();
        yield LoginSuccessfulState();
      } catch (e) {
        Navigator.of(event.context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return CustomAlertDialog(event.context);
            }));
      }
    } else if (event is GoogleButtonPressedEvent) {
      try {
        yield LoginLoadingState();
        await userController.signInWithGoogle();
        yield LoginSuccessfulState();
      } catch (e) {
        print("aa");
        Navigator.of(event.context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return CustomAlertDialog(event.context);
            }));
      }
    }
  }

  CustomAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 255, 104, 3),
            Color.fromARGB(255, 238, 11, 118),
            Color.fromARGB(255, 238, 11, 118),
          ]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      content: Text("Kindly provide correct details"),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => new LoginPage()));
          },
        ),
      ],
    );
    return alert;
  }
}
