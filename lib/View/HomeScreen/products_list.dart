
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Component/constanttext.dart';
import 'package:shopping_app_with_provider/Component/products.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/usersignupandsignIn.dart';
import 'package:shopping_app_with_provider/View/DetailScreen/productdetails.dart';
import 'package:shopping_app_with_provider/View/Loginscreen/loginscreen.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  TextFileConstant textFileConstant = TextFileConstant();
  UserAuthentication authentication = UserAuthentication();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ProductsItem productsItem = ProductsItem();
  bool isFavorite = false;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<DetailController>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xffA6D1E6),
      drawer: SafeArea(
        child: Drawer(
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          elevation: 1,
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                        radius: 40,
                        backgroundColor: Colors.black26,
                      ),
                      Text(
                        UserAuthentication.auth.currentUser!.displayName!,
                        style: textFileConstant.detailtitle,
                      )
                    ],
                  )),
              ListTile(
                onTap: () {
                  authentication.logout;
                  Provider.of<DetailController>(context, listen: false)
                      .removebool();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const Loginscreen();
                  }), (route) => false);
                },
                title: const Text('Log Out'),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
                radius: 18,
              ),
            ),
          )
        ],
        backgroundColor: const Color(0xffA6D1E6),
        title: const Text(
          "Shopping",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xffA6D1E6),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.white,
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.search_off,
                                  color: Color(0xff3AB4F2),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(top: 3, left: 20),
                                hintText: "Find shoes",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Alivable Items",
                        style: textFileConstant.titleStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: const Color(0xffA6D1E6),
              child: GridView.count(
                  crossAxisCount: 2,
                  children:
                      List.generate(productsItem.products.length, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return Shoedetails(
                                price: productsItem.products[index].price,
                                name: productsItem.products[index].name,
                                image: productsItem.products[index].image,
                              );
                            }))).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 180,
                            width: 160,
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 5,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$ ${productsItem.products[index].price.toString()}",
                                      style: textFileConstant.defultStyle,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                        },
                                        icon:
                                            const Icon(Icons.favorite_border)),
                                  ],
                                ),
                                Image(
                                    width: 100,
                                    height: 100,
                                    image: AssetImage(
                                        productsItem.products[index].image)),
                                Text(productsItem.products[index].name)
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
