import 'package:coffeshop/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRepo();

  Future<UserModel> signInWithGoogle() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();

    UserCredential result =
        await _auth.signInWithCredential(GoogleAuthProvider.credential(
      idToken: (await account!.authentication).idToken,
      accessToken: (await account.authentication).accessToken,
    ));

    updateDisplayName(result.user!.displayName.toString());
    result.user!.updateEmail(result.user!.email.toString());
    final flag = await emailCheck(result.user!.email.toString());
    if (flag) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.email.toString())
          .set({
        "username": result.user!.displayName,
        "email": result.user!.email,
        "dob": "",
        "gender": "",
        "phone": ""
      });
    } else {
      final results = await FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.email)
          .get()
          .then((value) {
        updateDisplayName(result.user!.displayName.toString());
      });
    }
    return UserModel(result.user!.uid,
        displayName: result.user!.displayName,
        email: result.user!.email,
        phone: result.user!.phoneNumber);
  }

  Future<UserModel> signInWithFacebook() async {
    final LoginResult account = await FacebookAuth.instance.login();

    UserCredential result = await _auth.signInWithCredential(
        FacebookAuthProvider.credential(account.accessToken!.token));

    updateDisplayName(result.user!.displayName.toString());
    result.user!.updateEmail(result.user!.email.toString());
    final flag = await emailCheck(result.user!.email.toString());
    if (flag) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.email.toString())
          .set({
        "username": result.user!.displayName,
        "email": result.user!.email,
        "dob": "",
        "gender": "",
        "phone": ""
      });
    } else {
      final results = await FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.email)
          .get()
          .then((value) {
        updateDisplayName(result.user!.displayName.toString());
      });
    }
    print("aa:" + result.user!.email.toString());
    return UserModel(result.user!.uid,
        displayName: result.user!.displayName,
        email: result.user!.email,
        phone: result.user!.phoneNumber);
  }

  Future<UserModel> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());
    updateDisplayName(userCredential.user!.displayName.toString());
    String name, gender, dob, phone;
    final flag = await emailCheck(userCredential.user!.email.toString());
    if (flag) {
      FirebaseFirestore.instance.collection("users").doc(email).set({
        "username": userCredential.user!.displayName,
        "email": email,
        "gender": "",
        "dob": "",
        "phone": "",
      });
    } else {
      final results = await FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .get()
          .then((value) {});
    }
    return UserModel(userCredential.user!.uid,
        displayName: userCredential.user!.displayName,
        email: email,
        dob: "",
        phone: "");
  }

  Future<UserModel> signUpWithEmailAndPassword({
    String? email,
    String? password,
    String? username,
    String? dob,
    String? phone,
  }) async {
    try {
      var userv = await _auth.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      var user = userv.user;
      updateDisplayName(username.toString());
      final flag = await emailCheck(user!.email.toString());
      if (flag) {
        FirebaseFirestore.instance.collection("users").doc(user.email).set({
          "username": username,
          "email": user.email,
          "gender": "",
          "dob": dob,
          "phone": phone,
        });
      } else {
        final results = await FirebaseFirestore.instance
            .collection("users")
            .doc(email)
            .get()
            .then((value) {
          updateDisplayName(username.toString());
        });
      }
      return UserModel(user.uid,
          displayName: username, email: email, dob: dob, phone: phone);
    } catch (e) {
      print("aa:" + e.toString());
    }
    return UserModel("null");
  }

  Future<bool> emailCheck(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isEmpty;
  }

  Future<void> updateDisplayName(String displayName) async {
    var user = await _auth.currentUser;
    user!.updateDisplayName(displayName.toString());
  }

  Future<bool> validatePassword(String email, String password) async {
    var firebaseUser = await _auth.currentUser;

    var authCredentials =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      var authResult =
          await firebaseUser!.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
