import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ToDoListEvent extends Equatable {}

class InitEvent extends ToDoListEvent {
  
  InitEvent();
  @override
  List<Object> get props => null;
}

class BtnEvent extends ToDoListEvent {
  @override
  List<Object> get props => null;
}

class EditBtnEvent extends ToDoListEvent {
  final int id;
  final BuildContext context;
  EditBtnEvent({this.context,this.id});
  @override
  List<Object> get props => null;
}

class DeleteBtnEvent extends ToDoListEvent {
  final int id;
  final BuildContext context;
  DeleteBtnEvent({this.context,this.id});
  @override
  List<Object> get props => null;
}

class CheckBoxChangedEvent extends ToDoListEvent {
  final int id,isDone;
  final BuildContext context;
  CheckBoxChangedEvent({this.id,this.isDone,this.context});
  @override
  List<Object> get props => null;
}