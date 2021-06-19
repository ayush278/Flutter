import 'package:coffeshop/bloc/cartBloc/cart_bloc.dart';
import 'package:coffeshop/bloc/homeBloc/home_bloc.dart';
import 'package:coffeshop/bloc/homeBloc/home_event.dart';
import 'package:coffeshop/bloc/homeBloc/home_state.dart';
import 'package:coffeshop/model/cart_model.dart';
import 'package:coffeshop/model/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc homeBlocObj;
  late CartBloc cartBlocObj;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 255, 104, 3),
      Color.fromARGB(255, 238, 11, 118),
    ],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    double gridItemWidth = MediaQuery.of(context).size.width / 2;
    double gridItemHeight = MediaQuery.of(context).size.height / 3;
    cartBlocObj = BlocProvider.of<CartBloc>(context);
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(HomeLoadingState)..add(InitEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is HomeInitialState) {
            homeBlocObj = BlocProvider.of<HomeBloc>(context);
            return SafeArea(
              child: Scaffold(
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset("assests/images/cafe.jpg",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade700,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 149, 120),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, right: 4),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "4",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Starbucks Coffee",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.grey.shade500,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 16.0,
                                            bottom: 16.0,
                                          ),
                                          child: Text(
                                            "Avenue St. 187",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.asset(
                                          "assests/images/gmap1.PNG",
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      Center(
                                        child: Icon(
                                          Icons.location_pin,
                                          color: Colors.red.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 242, 238),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.people_alt_outlined),
                                  )),
                              Flexible(
                                child: Text(
                                  "2990+ orders placed to make people smile",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Text(
                              "Promotion",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: StreamBuilder<List<CoffeeModel>>(
                              stream: homeBlocObj.promotionListStream,
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 250,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 1,
                                            child: ListTile(
                                              leading: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(14)),
                                                  child: Image.asset(
                                                    snapshot
                                                        .data![index].imageUrl
                                                        .toString(),
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                snapshot.data![index].coffeName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "\$" +
                                                    snapshot.data![index].price
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Text(
                              "Menu",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Align(
                            alignment: Alignment(-.9, 0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 255, 104, 3),
                                    Color.fromARGB(255, 238, 11, 118),
                                    Color.fromARGB(255, 238, 11, 118),
                                  ])),
                              child: Container(
                                width: 75,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                margin: EdgeInsets.all(1),
                                child: Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      elevation: 0,
                                      hint: Text(
                                        "All",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      iconDisabledColor: Colors.black,
                                      items: <String>[].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: "All",
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: StreamBuilder<List<CoffeeModel>>(
                              stream: homeBlocObj.itemListStream,
                              builder: (context, snapshot) {
                                return GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio:
                                      (gridItemWidth / gridItemHeight),
                                  children: List.generate(snapshot.data!.length,
                                      (index) {
                                    cartBlocObj.counter.add(0);
                                    int? itemNum =
                                        snapshot.data![index].pastOrder;
                                    int? itemPrice =
                                        snapshot.data![index].price!.round();
                                    String? itemName =
                                        snapshot.data![index].coffeName;
                                    return FractionallySizedBox(
                                      widthFactor: 0.95,
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: gridItemHeight / 2,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15)),
                                                child: Image.asset(
                                                  snapshot.data![index].imageUrl
                                                      .toString(),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 4, left: 4),
                                              height: (gridItemHeight / 2) - 15,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text("$itemNum" + "+ ordered",
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                  Text("$itemName",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("\$" + "$itemPrice",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      Container(
                                                        width:
                                                            gridItemWidth / 2,
                                                        child: StreamBuilder<
                                                                List<int>>(
                                                            stream: cartBlocObj
                                                                .itemCounterStream,
                                                            builder: (context,
                                                                snapshot) {
                                                              bool temp = false;
                                                              if (snapshot
                                                                      .data![
                                                                          index]
                                                                      .toString() ==
                                                                  "0") {
                                                                temp = true;
                                                              }
                                                              return temp ==
                                                                      true
                                                                  ? FractionallySizedBox(
                                                                      widthFactor:
                                                                          0.8,
                                                                      child:
                                                                          DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                            gradient: LinearGradient(colors: [
                                                                              Color.fromARGB(255, 255, 104, 3),
                                                                              Color.fromARGB(255, 238, 11, 118),
                                                                              Color.fromARGB(255, 238, 11, 118),
                                                                            ])),
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            cartBlocObj.addCart(CartModel(
                                                                                coffeName: itemName,
                                                                                price: itemPrice));
                                                                            cartBlocObj.incrementCounter(index);
                                                                            setState(() {});
                                                                          },
                                                                          style: ElevatedButton.styleFrom(
                                                                              minimumSize: Size.zero,
                                                                              padding: EdgeInsets.zero,
                                                                              elevation: 0,
                                                                              primary: Colors.transparent),
                                                                          child:
                                                                              Text(
                                                                            'Add',
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : FractionallySizedBox(
                                                                      widthFactor:
                                                                          0.8,
                                                                      child:
                                                                          DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                            gradient: LinearGradient(colors: [
                                                                              Color.fromARGB(255, 255, 104, 3),
                                                                              Color.fromARGB(255, 238, 11, 118),
                                                                              Color.fromARGB(255, 238, 11, 118),
                                                                            ])),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          margin:
                                                                              EdgeInsets.all(1),
                                                                          child:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              minimumSize: Size.zero,
                                                                              padding: EdgeInsets.zero,
                                                                              elevation: 0,
                                                                              primary: Colors.transparent,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              cartBlocObj.addCart(CartModel(coffeName: itemName, price: itemPrice));
                                                                              cartBlocObj.incrementCounter(index);
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Add more",
                                                                              style: new TextStyle(foreground: new Paint()..shader = linearGradient),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: StreamBuilder<int>(
                    stream: cartBlocObj.totalCartPriceStream,
                    builder: (context, snapshot) {
                      return Visibility(
                        visible: snapshot.data == 0 ? false : true,
                        child: Card(
                          elevation: 66,
                          child: Container(
                            padding: EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 255, 104, 3),
                                    Color.fromARGB(255, 238, 11, 118),
                                    Color.fromARGB(255, 238, 11, 118),
                                  ])),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    elevation: 0,
                                    primary: Colors.transparent),
                                child: StreamBuilder<int>(
                                    stream: cartBlocObj.totalCartPriceStream,
                                    builder: (context, snapshot) {
                                      return Text(
                                        'Checkout - \$' +
                                            snapshot.data.toString(),
                                        style: TextStyle(fontSize: 16),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
