import 'package:equatable/equatable.dart';

abstract class NewTaskPageState extends Equatable {}

class NewTaskPageInitState extends NewTaskPageState {
  NewTaskPageInitState();
  @override
  List<Object> get props => null;
}

class NewTaskPageLoadingState extends NewTaskPageState {
  @override
  List<Object> get props => null;
}

class NewTaskPageSuccessfulState extends NewTaskPageState {
  NewTaskPageSuccessfulState();

  @override
  List<Object> get props => null;
}

class NewTaskPageFailureState extends NewTaskPageState {
  @override
  List<Object> get props => null;
}
