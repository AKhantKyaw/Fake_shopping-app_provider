import 'package:flutter/material.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavorateScreenState();
}

class _FavorateScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA6D1E6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffA6D1E6),
        title: const Text('Your Favorite'),
      ),
      body: Column(
        children: const [
        ],
      ),
    );
  }
}
