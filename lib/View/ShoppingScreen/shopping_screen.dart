import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Component/alartdialog.dart';
import 'package:shopping_app_with_provider/Component/constanttext.dart';
import 'package:shopping_app_with_provider/Component/coustomsnackbar.dart';
import 'package:shopping_app_with_provider/Component/plusminusbutton.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/Controller/Services/Database/database_helper.dart';
import 'package:shopping_app_with_provider/Model/datamodel.dart';
import 'package:shopping_app_with_provider/View/Checkout/Checkoutscreen.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({
    Key? key,
  }) : super(key: key);
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  TextFileConstant textFileConstant = TextFileConstant();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailController>(context);
    return Scaffold(
        backgroundColor: const Color(0xffA6D1E6),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xffA6D1E6),
          title: Text(
            "My Cart",
            style: textFileConstant.titleStyle,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Consumer<DetailController>(
                builder: (context, value, child) {
                  if (value.cart.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child:
                                SvgPicture.asset('images/empty-shopping.svg')),
                        Text(
                          "Your cart is Empty",
                          style: textFileConstant.titleStyle,
                        ),
                      ],
                    ));
                  } else if (value.cart.isNotEmpty) {
                    return ListView.builder(
                        itemCount: provider.cart.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white70,
                                      ),
                                      width: 150,
                                      height: 200,
                                      child: Image.asset(
                                          provider.cart[index].image),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider
                                                      .cart[index].productName,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "\$ ${provider.cart[index].initialPrice.toString()}",
                                                  style: textFileConstant
                                                      .defultStyle,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Quality : ${provider.cart[index].quality}',
                                                  style: textFileConstant
                                                      .defultStyle,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Color : ',
                                                      style: textFileConstant
                                                          .defultStyle,
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Color(provider
                                                              .cart[index]
                                                              .color),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          ValueListenableBuilder<int>(
                                              valueListenable:
                                                  provider.cart[index].count!,
                                              builder: (context, value, child) {
                                                return Row(
                                                  children: [
                                                    PlusMinusButtons(
                                                        addQuantity: () {
                                                          provider.addQuantity(
                                                              provider
                                                                  .cart[index]
                                                                  .id!);
                                                          databaseHelper
                                                              .updatecount(Cart(
                                                                  id: index,
                                                                  count: ValueNotifier(
                                                                      provider
                                                                          .cart[
                                                                              index]
                                                                          .count!
                                                                          .value),
                                                                  color: provider
                                                                      .cart[
                                                                          index]
                                                                      .color,
                                                                  productName: provider
                                                                      .cart[
                                                                          index]
                                                                      .productName,
                                                                  image: provider
                                                                      .cart[
                                                                          index]
                                                                      .image,
                                                                  initialPrice: provider
                                                                      .cart[
                                                                          index]
                                                                      .initialPrice,
                                                                  productPrice: provider
                                                                      .cart[
                                                                          index]
                                                                      .productPrice,
                                                                  quality: provider
                                                                      .cart[
                                                                          index]
                                                                      .quality))
                                                              .then((value) {
                                                            setState(() {
                                                              provider.addTotalPrice(
                                                                  double.parse(provider
                                                                      .cart[
                                                                          index]
                                                                      .productPrice
                                                                      .toString()));
                                                            });
                                                          });
                                                        },
                                                        deleteQuantity: () {
                                                          provider
                                                              .deleteQuantity(
                                                                  provider
                                                                      .cart[
                                                                          index]
                                                                      .id!);
                                                          provider.removeTotalPrice(
                                                              double.parse(provider
                                                                  .cart[index]
                                                                  .productPrice
                                                                  .toString()));
                                                        },
                                                        text: value.toString()),
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          showMyDialog(
                                                              context,
                                                              provider
                                                                  .cart[index]
                                                                  .id);
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .delete_outline_outlined,
                                                          size: 30,
                                                        )),
                                                  ],
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }));
                  }
                  return const Text("data");
                },
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Consumer<DetailController>(
                  builder: (context, value, child) {
                    final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                    for (var element in value.cart) {
                      totalPrice.value =
                          (element.productPrice * element.count!.value) +
                              (totalPrice.value ?? 0);
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 40,
                      child: ValueListenableBuilder<int?>(
                        valueListenable: totalPrice,
                        builder: (context, value, child) {
                          return Text(
                            "Total price : \$ ${value ?? '0'}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    );
                  },
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize:
                            MaterialStateProperty.all(const Size(350, 50))),
                    onPressed: () {
                      if (provider.cart.isEmpty) {
                        CustomSnackBar.showErrorSnackBar(context,
                            message:
                                'Your card is not empty\n please add items');
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Checkout();
                        }));
                      }
                    },
                    child: const Text("Checkout")),
              ],
            ))
          ],
        ));
  }
}
