import 'package:coffeshop/bloc/loginBloc/login_bloc.dart';
import 'package:coffeshop/bloc/loginBloc/login_event.dart';
import 'package:coffeshop/bloc/loginBloc/login_state.dart';
import 'package:coffeshop/helper/validationFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homeview.dart';
import 'registerationview.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Validator validatorObj = new Validator();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _loginbtnFocusNode = FocusNode();
  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  late LoginBloc loginBloc;
  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(255, 255, 104, 3),
          Color.fromARGB(255, 238, 11, 118),
          Color.fromARGB(255, 238, 11, 118),
        ])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Text(
                      "Coffe Shop",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              BlocListener<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSuccessfulState) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()),
                                    );
                                  }
                                },
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is LoginInitialState) {
                                      return buildInitialUi();
                                    } else if (state is LoginLoadingState) {
                                      return Container();
                                    } else if (state is LoginSuccessfulState) {
                                      return Container();
                                    } else if (state is LoginFailureState) {
                                      return Material(
                                          type: MaterialType.transparency,
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: buildLoadingUi()));
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(175, 255, 104, 3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: StreamBuilder<String>(
                                          stream: loginBloc.emailStream,
                                          builder: (context, snapshot) {
                                            return TextFormField(
                                              focusNode: _emailFocusNode,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  icon:
                                                      Icon(Icons.perm_identity),
                                                  border: InputBorder.none),
                                              textInputAction:
                                                  TextInputAction.next,
                                              validator: (email) {
                                                validatorObj
                                                    .validateEmail(email!);
                                              },
                                              onFieldSubmitted: (_) {
                                                fieldFocusChange(
                                                    context,
                                                    _emailFocusNode,
                                                    _passwordFocusNode);
                                              },
                                              controller: userController,
                                            );
                                          }),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        focusNode: _passwordFocusNode,
                                        autofocus: true,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            focusColor: Colors.amber,
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(
                                              Icons.lock_outline,
                                            ),
                                            border: InputBorder.none),
                                        controller: passwordController,
                                        textInputAction: TextInputAction.done,
                                        validator: (password) {
                                          validatorObj
                                              .validatePassword(password!);
                                        },
                                        onFieldSubmitted: (_) {
                                          fieldFocusChange(
                                              context,
                                              _passwordFocusNode,
                                              _loginbtnFocusNode);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    width: 120,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40.0),
                                        ),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            colors: [
                                              Color.fromARGB(255, 255, 104, 3),
                                              Color.fromARGB(255, 238, 11, 118),
                                              Color.fromARGB(255, 238, 11, 118),
                                            ]),
                                      ),
                                      child: ElevatedButton(
                                        focusNode: _loginbtnFocusNode,
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          elevation: 0,
                                          shadowColor: Colors.transparent,
                                        ),
                                        autofocus: false,
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            loginBloc.add(
                                                LoginButtonPressedEvent(context,
                                                    email: userController.text,
                                                    password: passwordController
                                                        .text));
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Continue with social media",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () async {
                                        loginBloc.add(
                                            FacebookButtonPressedEvent(
                                                context));
                                      },
                                      child: Image.asset(
                                          'assests/images/icon_facebook_circle.png')),
                                  TextButton(
                                    onPressed: () async {
                                      loginBloc.add(
                                          GoogleButtonPressedEvent(context));
                                    },
                                    child: Image.asset(
                                        'assests/images/icon_google_multicolored.png'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterationPage()));
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don\'t have an Account? ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                )),
          )
        ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
          ),
          Container(
              margin: EdgeInsets.only(left: 5), child: Text("    Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildInitialUi() {
    return Center(
      child: Text(""),
    );
  }

  AlertDialog buildLoadingUi() {
    AlertDialog loading = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
          ),
          Container(
              margin: EdgeInsets.only(left: 5), child: Text("    Loading")),
        ],
      ),
    );
    return loading;
  }

  Widget buildFailureUi() {
    return Center(
      child: Text(""),
    );
  }
}
