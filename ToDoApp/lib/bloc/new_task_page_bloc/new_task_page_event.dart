import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NewTaskPageEvent extends Equatable {}

class InitEvent extends NewTaskPageEvent {
 final int id;
  InitEvent(this.id);
  @override
  List<Object> get props => null;
}
class SelectDateEvent extends NewTaskPageEvent {
 final BuildContext context;
  SelectDateEvent(this.context);
  @override
  List<Object> get props => null;
}

class CheckBtnEvent extends NewTaskPageEvent {
  final BuildContext context;
  final int id;
  CheckBtnEvent(this.context,this.id);
  @override
  List<Object> get props => null;
}
class BtnEvent extends NewTaskPageEvent {
  @override
  List<Object> get props => null;
}
