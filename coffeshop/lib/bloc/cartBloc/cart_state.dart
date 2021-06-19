abstract class CartState {}

class CartInitialState extends CartState {}

class UserLoadingState extends CartState {}

class CartSuccessfulState extends CartState {
  CartSuccessfulState();
}

class CartFailureState extends CartState {
  String? message;
  CartFailureState({this.message});
}
