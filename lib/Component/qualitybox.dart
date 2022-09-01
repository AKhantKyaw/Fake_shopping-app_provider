import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Qualitybox extends StatelessWidget {
  Qualitybox({Key? key, required this.name, required this.color})
      : super(key: key);
  String name;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      height: 40,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: color,
          border: Border.all(color: Colors.white)),
    );
  }
}
