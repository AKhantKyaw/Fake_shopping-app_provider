import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/View/HomeScreen/homescreen.dart';

Future<void> showMyDialog(context, index) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white70,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(' Delete'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure delete this Item?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              final provider =
                  Provider.of<DetailController>(context, listen: false);
              provider.deleteData(index);
              provider.getData();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> successDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white70,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Payment'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 20,
                  child: Center(
                    child: Icon(Icons.check),
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
              Text('Payment Successfully'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            },
          ),
        ],
      );
    },
  );
}
