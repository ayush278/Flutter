abstract class UserRegState {}

class UserRegInitialState extends UserRegState {}

class UserLoadingState extends UserRegState {}

class UserRegSuccessfulState extends UserRegState {
  UserRegSuccessfulState();
}

class UserRegFailureState extends UserRegState {
  String? message;
  UserRegFailureState({this.message});
}
