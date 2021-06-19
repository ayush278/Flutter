import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coffeshop/helper/db_helper.dart';
import 'package:coffeshop/model/coffee_model.dart';

import 'package:rxdart/rxdart.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(initialState) : super(HomeInitialState());
  final List<CoffeeModel> promotionList = [
    CoffeeModel(
        coffeName: "Iced Cappucino",
        price: 20,
        imageUrl: "assests/images/holdcup1.jpg"),
    CoffeeModel(
        coffeName: "Iced Cappucino",
        price: 20,
        imageUrl: "assests/images/holdcup1.jpg")
  ];

  List<CoffeeModel> menuList = [];

  final promotionListStreamController = BehaviorSubject<List<CoffeeModel>>();
  Stream<List<CoffeeModel>> get promotionListStream =>
      promotionListStreamController.stream;
  StreamSink<List<CoffeeModel>> get promotionListSink =>
      promotionListStreamController.sink;

  Function(List<CoffeeModel>) get promotionListChanged =>
      promotionListStreamController.sink.add;

  final itemListStreamController = BehaviorSubject<List<CoffeeModel>>();
  Stream<List<CoffeeModel>> get itemListStream =>
      itemListStreamController.stream;
  StreamSink<List<CoffeeModel>> get itemListSink =>
      itemListStreamController.sink;

  Function(List<CoffeeModel>) get itemListChanged =>
      itemListStreamController.sink.add;
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    DbHelper dbhelperObj = DbHelper();

    if (event is InitEvent) {
      yield HomeLoadingState();
      promotionListStreamController.value = promotionList;

      menuList = await dbhelperObj.getCoffeeMenuFirebase();
      itemListStreamController.value = menuList;
      yield HomeInitialState();
    }
  }

  void dispose() {
    promotionListStreamController.close();
    itemListStreamController.close();
  }
}
