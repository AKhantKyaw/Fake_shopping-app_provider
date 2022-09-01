import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:shopping_app_with_provider/Component/constanttext.dart';
import 'package:shopping_app_with_provider/Component/coustomsnackbar.dart';
import 'package:shopping_app_with_provider/Component/qualitybox.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/Controller/Services/Database/database_helper.dart';
import 'package:shopping_app_with_provider/Model/datamodel.dart';

class Shoedetails extends StatefulWidget {
  const Shoedetails(
      {Key? key, required this.image, required this.name, required this.price})
      : super(key: key);
  final String name;
  final int price;
  final String image;
  @override
  State<Shoedetails> createState() => _ShoedetailsState();
}

class _ShoedetailsState extends State<Shoedetails>
    with TickerProviderStateMixin {
  TextFileConstant textFileConstant = TextFileConstant();
  DetailController controller = DetailController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  CustomSnackBar customSnackBar = CustomSnackBar();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdded = true;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xffA6D1E6),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Details",
          style: textFileConstant.titleStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.teal,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(50))),
                    child: AnimatedBuilder(
                      animation: _controller,
                      child: Center(
                        child: SizedBox(
                            width: 200,
                            child: Image(image: AssetImage(widget.image))),
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return Transform.rotate(
                          angle: _controller.value * 0.3 * math.pi,
                          child: child,
                        );
                      },
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    decoration: const BoxDecoration(
                        color: Colors.teal,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name,
                              style: textFileConstant.detailtitle,
                            ),
                            const Text(
                              "Color : ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            Consumer<DetailController>(
                                builder: ((context, value, child) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: value.color,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 30,
                                width: 50,
                              );
                            })),
                          ],
                        ),
                        Text(
                          "Price: \$ ${widget.price.toString()}",
                          style: textFileConstant.detailtitle,
                        ),
                        const Text("Alivable Colors",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.alivableColor.length,
                              itemBuilder: ((BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<DetailController>(context,
                                              listen: false)
                                          .ableColor(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              controller.alivableColor[index],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 30,
                                      width: 40,
                                    ),
                                  ),
                                );
                              })),
                        ),
                        Text(
                          "Quality",
                          style: textFileConstant.detailtitle,
                        ),
                        Builder(builder: ((context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<DetailController>().lowQuality();
                                },
                                child: Consumer<DetailController>(
                                  builder: (context, value, child) {
                                    return Qualitybox(
                                      name: "Low",
                                      color: value.qualitystatus ==
                                              Qualitystatus.low
                                          ? Colors.orange
                                          : Colors.transparent,
                                    );
                                  },
                                ),
                              ),
                              GestureDetector(onTap: () {
                                context
                                    .read<DetailController>()
                                    .mediumQuality();
                              }, child: Consumer<DetailController>(
                                builder: (context, value, child) {
                                  return Qualitybox(
                                    name: "Medium",
                                    color: value.qualitystatus ==
                                            Qualitystatus.medium
                                        ? Colors.amber
                                        : Colors.transparent,
                                  );
                                },
                              )),
                              GestureDetector(onTap: () {
                                context.read<DetailController>().highQuality();
                              }, child: Consumer<DetailController>(
                                  builder: (context, value, child) {
                                return Qualitybox(
                                  name: "High",
                                  color:
                                      value.qualitystatus == Qualitystatus.high
                                          ? Colors.black
                                          : Colors.transparent,
                                );
                              })),
                            ],
                          );
                        })),
                        Builder(builder: (context) {
                          final provider =
                              Provider.of<DetailController>(context);
                          return ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        topRight: Radius.circular(50)),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffA2B5BB)),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(350, 50))),
                              onPressed: () {
                                if (isAdded) {
                                  isAdded = false;
                                  provider.setdata(Cart(
                                    productName: widget.name,
                                    image: widget.image,
                                    initialPrice: widget.price,
                                    productPrice: widget.price,
                                    color: provider.color.value,
                                    quality: provider.quality,
                                    count: ValueNotifier(1),
                                  ));
                                  provider.getData();
                                  CustomSnackBar.showSuccessSnackBar(
                                      scaffoldKey.currentContext!,
                                      message:
                                          'This item is added to your Shopping cart');
                                } else {
                                  isAdded = true;
                                  CustomSnackBar.showErrorSnackBar(context,
                                      message: 'No need to add this is added');
                                }
                              },
                              child: const Text(
                                "Add To Cart",
                                style: TextStyle(color: Colors.black),
                              ));
                        })
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
