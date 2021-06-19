import 'package:coffeshop/model/user_model.dart';
import 'package:coffeshop/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  late UserModel _currentUser;
  AuthRepo _authRepo = AuthRepo();
  late Future init;

  UserController() {
    //  init = initUser();
  }

  Future<UserModel> initUser() async {
    // _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  Future<void> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    _currentUser = await _authRepo.signInWithGoogle();
  }

  Future<void> signInWithFacebook() async {
    _currentUser = await _authRepo.signInWithFacebook();
  }

  Future<void> signUpWithEmailAndPassword(
      {String? email,
      String? password,
      String? username,
      String? dob,
      String? phone}) async {
    _currentUser = await _authRepo.signUpWithEmailAndPassword(
      email: email,
      password: password,
      username: username,
      dob: dob,
      phone: phone,
    );
  }

  Future<bool> validateCurrentPassword(String? email, String? password) async {
    return await _authRepo.validatePassword(
        email.toString(), password.toString());
  }

  Future<bool> initCheckPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('isUser') as bool) {
      return true;
    }
    return false;
  }
}
