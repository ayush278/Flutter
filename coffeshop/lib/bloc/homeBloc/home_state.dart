abstract class HomeState {}

class HomeInitialState extends HomeState {
  HomeInitialState();
}

class HomeLoadingState extends HomeState {}

class HomeSuccessfulState extends HomeState {
  HomeSuccessfulState();
}

class HomeFailureState extends HomeState {
  String? message;
  HomeFailureState({this.message});
}
