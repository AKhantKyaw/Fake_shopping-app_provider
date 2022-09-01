import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Component/alartdialog.dart';
import 'package:shopping_app_with_provider/Component/constanttext.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextFileConstant textFileConstant = TextFileConstant();
  final fbKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xffA6D1E6),
        elevation: 0,
        title: const Text(
          'Check Out',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Form(
        key: fbKey,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('images/icons8-payment-64.png')),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                width: 300,
                height: 200,
              )),
              color: const Color(0xffA6D1E6),
            )),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: 'Enter your Address'),
                    ),
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
                        if (fbKey.currentState!.validate()) {
                          successDialog(context);
                          Provider.of<DetailController>(context,listen: false)
                              .deletecartall();
                        }
                      },
                      child: const Text("Pay Now")),
                ],
              ),
              color: const Color(0xffA6D1E6),
            ))
          ],
        ),
      ),
    );
  }
}
