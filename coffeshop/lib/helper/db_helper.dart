import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeshop/model/coffee_model.dart';

class DbHelper {
  Future getCoffeeMenuFirebase() async {
    List<CoffeeModel> menuList = [];

    var docList = await FirebaseFirestore.instance.collection("Coffee").get()
      ..docs;
    List<int> docL = [];
    docList.docs.forEach((element) {
      docL.add(int.parse(element.id.toString()));
    });
    for (int i = 0; i < docL.length; i++) {
      var docData = await FirebaseFirestore.instance
          .collection("Coffee")
          .doc(docL[i].toString())
          .get();
      menuList.add(CoffeeModel(
          coffeName: docData.get("coffeName"),
          imageUrl: docData.get("imageUrl"),
          pastOrder: int.parse(docData.get("pastOrder")),
          price: int.parse(docData.get("price"))));
    }

    return menuList;
  }
}
