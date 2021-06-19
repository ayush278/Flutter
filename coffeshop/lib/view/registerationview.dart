import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeshop/helper/validationFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:community_material_icon/community_material_icon.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/registerationBloc/user_reg_bloc.dart';
import '../bloc/registerationBloc/user_reg_event.dart';
import '../bloc/registerationBloc/user_reg_state.dart';
import 'loginview.dart';

class RegisterationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegBloc(),
      child: RegisterationView(),
    );
  }
}

class RegisterationView extends StatefulWidget {
  @override
  _RegisterationViewState createState() => _RegisterationViewState();
}

class _RegisterationViewState extends State<RegisterationView> {
  late SharedPreferences logindata;
  Validator validatorObj = new Validator();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  final _formKey = GlobalKey<FormState>();
  var myFormat = DateFormat('d-MM-yyyy');
  TextEditingController dateCtl = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _registerbtnFocusNode = FocusNode();
  String a = "1";

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<bool> emailCheck(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isEmpty;
  }

  late UserRegBloc userRegBloc;

  @override
  Widget build(BuildContext context) {
    userRegBloc = BlocProvider.of<UserRegBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 255, 104, 3),
            Color.fromARGB(255, 238, 11, 118),
            Color.fromARGB(255, 238, 11, 118),
          ])),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocListener<UserRegBloc, UserRegState>(
                    listener: (context, state) {
                      if (state is UserRegSuccessfulState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    },
                    child: BlocBuilder<UserRegBloc, UserRegState>(
                        builder: (context, state) {
                      if (state is UserRegInitialState) {
                        return buildInitialUi();
                      } else if (state is UserLoadingState) {
                        return buildLoadingUi();
                      } else if (state is UserRegSuccessfulState) {
                        return Container();
                      } else if (state is UserRegFailureState) {
                        return buildFailureUi(state.message!);
                      } else {
                        return Container();
                      }
                    }),
                  ),
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
            SizedBox(height: 8),
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
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.orangeAccent.shade200,
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: StreamBuilder<Object>(
                                      stream: userRegBloc.userName,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          focusNode: _nameFocusNode,
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            labelText: "Name",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(Icons.perm_identity),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: userRegBloc.changeUserName,
                                          controller: nameController,
                                          validator: (name) {
                                            return validatorObj
                                                .validateName(name!);
                                          },
                                          onFieldSubmitted: (_) {
                                            fieldFocusChange(
                                                context,
                                                _nameFocusNode,
                                                _emailFocusNode);
                                          },
                                        );
                                      }),
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: dateCtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Date of birth",
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        icon: Icon(Icons.date_range),
                                      ),
                                      onTap: () async {
                                        DateTime date = DateTime(1900);
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());

                                        date = (await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2019, 1, 1),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100)))!;

                                        dateCtl.text = myFormat.format(date);
                                      },
                                      validator: (dob) {
                                        return validatorObj.validateDob(dob!);
                                      },
                                    )),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: StreamBuilder<Object>(
                                      stream: userRegBloc.userEmail,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          focusNode: _emailFocusNode,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            labelText: "Email",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(Icons.alternate_email),
                                            border: InputBorder.none,
                                          ),
                                          onChanged:
                                              userRegBloc.changeUserEmail,
                                          textInputAction: TextInputAction.next,
                                          validator: (email) {
                                            return validatorObj
                                                .validateEmail(email!);
                                          },
                                          onFieldSubmitted: (_) {
                                            try {
                                              fieldFocusChange(
                                                  context,
                                                  _emailFocusNode,
                                                  _phoneFocusNode);
                                            } catch (signUpError) {
                                              if (signUpError
                                                  is PlatformException) {
                                                if (signUpError.code ==
                                                    'ERROR_EMAIL_ALREADY_IN_USE') {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: new Text(
                                                            "Alert Dialog title"),
                                                        content: new Text(
                                                            "Alert Dialog body"),
                                                        actions: <Widget>[
                                                          new TextButton(
                                                            child: new Text(
                                                                "Close"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            }
                                          },
                                          controller: emailController,
                                        );
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: StreamBuilder<Object>(
                                      stream: userRegBloc.userPhone,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          focusNode: _phoneFocusNode,
                                          autofocus: true,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            labelText: "Phone",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(CommunityMaterialIcons
                                                .cellphone_basic),
                                            border: InputBorder.none,
                                          ),
                                          onChanged:
                                              userRegBloc.changeUserPhone,
                                          validator: (phone) {
                                            return validatorObj
                                                .validatePhoneNumber(phone!);
                                          },
                                          controller: phoneController,
                                          onFieldSubmitted: (_) {
                                            fieldFocusChange(
                                                context,
                                                _phoneFocusNode,
                                                _passwordFocusNode);
                                          },
                                        );
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: StreamBuilder<Object>(
                                      stream: userRegBloc.userPassword,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          focusNode: _passwordFocusNode,
                                          autofocus: true,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(
                                              Icons.lock_outline,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onChanged:
                                              userRegBloc.changeUserPassword,
                                          controller: passwordController,
                                          textInputAction: TextInputAction.done,
                                          validator: (password) {
                                            String pattern = r'^.{6,12}$';
                                            RegExp regex = new RegExp(pattern);
                                            if (password!.length == 0) {
                                              return 'Enter the password';
                                            } else if (password.length < 6) {
                                              return 'Password should have alteaset 6 characters';
                                            } else if (!regex
                                                .hasMatch(password))
                                              return 'Invalid password';
                                            else
                                              return null;
                                          },
                                          onFieldSubmitted: (_) {
                                            fieldFocusChange(
                                                context,
                                                _passwordFocusNode,
                                                _registerbtnFocusNode);
                                          },
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      gradient: LinearGradient(colors: [
                                        Color.fromARGB(255, 255, 104, 3),
                                        Color.fromARGB(255, 238, 11, 118),
                                        Color.fromARGB(255, 238, 11, 118),
                                      ])),
                                  child: MaterialButton(
                                    focusNode: _registerbtnFocusNode,
                                    autofocus: true,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        bool flagEmail = await emailCheck(
                                            emailController.text);
                                        if (flagEmail) {
                                          userRegBloc.add(
                                              SignUpButtonPressedEvent(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  dob: dateCtl.text,
                                                  phone: phoneController.text,
                                                  username:
                                                      nameController.text));
                                        } else {
                                          showInSnackBar(
                                              "Email already registered");
                                        }
                                      }
                                    },
                                    minWidth: 200.0,
                                    height: 45.0,
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
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

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
