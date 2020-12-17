import 'package:equatable/equatable.dart';

abstract class ToDoListState extends Equatable {}

class ToDoListInitState extends ToDoListState {
  ToDoListInitState();
  @override
  List<Object> get props => null;
}

class ToDoListLoadingState extends ToDoListState {
  @override
  List<Object> get props => null;
}

class ToDoListSuccessfulState extends ToDoListState {
  ToDoListSuccessfulState();

  @override
  List<Object> get props => null;
}

class ToDoListFailureState extends ToDoListState {
  @override
  List<Object> get props => null;
}
