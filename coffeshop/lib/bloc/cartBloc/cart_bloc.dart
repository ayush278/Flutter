import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coffeshop/model/cart_model.dart';
import 'package:coffeshop/model/coffee_model.dart';
import 'package:rxdart/rxdart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(initialState) : super(CartInitialState());
  List<CartModel> cart = [];
  List<int> counter = [];
  final _totalCartPriceStreamController = BehaviorSubject<int>();
  Stream<int> get totalCartPriceStream =>
      _totalCartPriceStreamController.stream;
  StreamSink<int> get totalCartPriceSink =>
      _totalCartPriceStreamController.sink;
  Function(int) get totalCartPriceChanged =>
      _totalCartPriceStreamController.sink.add;

  final _itemCounterStreamController = BehaviorSubject<List<int>>();
  Stream<List<int>> get itemCounterStream =>
      _itemCounterStreamController.stream;
  StreamSink<List<int>> get itemCountereSink =>
      _itemCounterStreamController.sink;
  Function(List<int>) get itemCounterChanged =>
      _itemCounterStreamController.sink.add;

  final _itemListStreamController = BehaviorSubject<List<CoffeeModel>>();
  Stream<List<CoffeeModel>> get itemListStream =>
      _itemListStreamController.stream;
  StreamSink<List<CoffeeModel>> get itemListSink =>
      _itemListStreamController.sink;

  Function(List<CoffeeModel>) get itemListChanged =>
      _itemListStreamController.sink.add;
  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    _totalCartPriceStreamController.value = 0;

    if (event is InitEvent) {
      counter.add(0);
      _itemCounterStreamController.value = counter;
    }
  }

  addCart(CartModel cartModelObj) {
    int totalItemPrice = 0;
    bool flag = true;
    if (cart.isNotEmpty) {
      cart.forEach((element) {
        totalItemPrice = totalItemPrice +
            (element.price! * int.parse(element.quant.toString()));
        if (element.coffeName == cartModelObj.coffeName) {
          flag = false;
          totalItemPrice =
              totalItemPrice + int.parse(cartModelObj.price.toString());
          element.quant = int.parse(element.quant.toString()) + 1;
        }
      });
    }
    if (cart.isEmpty || flag) {
      totalItemPrice =
          totalItemPrice + int.parse(cartModelObj.price.toString());
      cart.add(CartModel(
          coffeName: cartModelObj.coffeName,
          price: cartModelObj.price,
          quant: 1));
    }
    _totalCartPriceStreamController.value = totalItemPrice;
  }

  incrementCounter(int index) {
    counter[index]++;
  }

  void dispose() {
    _itemListStreamController.close();
    _totalCartPriceStreamController.close();
    _itemCounterStreamController.close();
  }
}
