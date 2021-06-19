import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cartBloc/cart_bloc.dart';
import 'bloc/cartBloc/cart_event.dart';
import 'bloc/cartBloc/cart_state.dart';
import 'view/loginview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc(CartSuccessfulState)..add(InitEvent()),
      child: MaterialApp(
          title: 'Flutter POC',
          theme: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            accentColor: Color(0xFF000000),
            textTheme: ThemeData.light().textTheme.copyWith(
                  button: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
          ),
          home: LoginPage()),
    );
  }
}
