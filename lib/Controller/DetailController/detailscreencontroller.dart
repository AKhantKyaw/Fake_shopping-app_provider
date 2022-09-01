import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app_with_provider/Controller/Services/Database/database_helper.dart';
import 'package:shopping_app_with_provider/Model/datamodel.dart';

enum Qualitystatus { low, medium, high }

class DetailController with ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Color color = const Color(0xffBB6464);
  Qualitystatus qualitystatus = Qualitystatus.low;
  String quality = "low";
  double totalPrice = 0.0;
  bool isadded = true;
  List<Cart> cart = [];
  int count = 1;
  bool islogin = false;
  List<Color> alivableColor = const [
    Color(0xffBB6464),
    Color(0xff7882A4),
    Color(0xff54BAB9),
    Color(0xffFF9F45),
    Color(0xffC3DBD9),
  ];
  Color ableColor(int index) {
    color = alivableColor[index];
    notifyListeners();
    return color;
  }

  lowQuality() {
    qualitystatus = Qualitystatus.low;
    quality = "low";
    notifyListeners();
  }
  mediumQuality() {
    qualitystatus = Qualitystatus.medium;
    quality = "medium";
    notifyListeners();
  }

  highQuality() {
    qualitystatus = Qualitystatus.high;
    quality = "high";
    notifyListeners();
  }

  setdata(Cart cart) async {
    await databaseHelper.insertCart(cart);
    notifyListeners();
  }

  getData() async {
    cart = await databaseHelper.retrieveCart();
    notifyListeners();
  }

  deleteData(int id) async {
    await databaseHelper.deleteCartItem(id);
    notifyListeners();
  }
  deletecartall() async {
    await databaseHelper.deletedatabase();

    notifyListeners();
  }

  void addQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].count!.value = cart[index].count!.value + 1;
    notifyListeners();
  }

  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].count!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].count!.value = currentQuantity - 1;
    }
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    totalPrice = totalPrice + productPrice;
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    totalPrice = totalPrice - productPrice;
    notifyListeners();
  }

  setprefesbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    islogin = await prefs.setBool('islogin', true);
    notifyListeners();
    return islogin;
  }

  getprefesbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    islogin = prefs.getBool('islogin') ?? false;
    // print(islogin);
    notifyListeners();
    return islogin;
  }

  removebool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}
