import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/View/HomeScreen/homescreen.dart';
import 'package:shopping_app_with_provider/View/Loginscreen/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailController>(context, listen: false).getprefesbool();
    });
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  Provider.of<DetailController>(context).islogin
                      ? const HomeScreen()
                      : const Loginscreen())),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              SvgPicture.asset('images/shopping-bag-svgrepo-com.svg'),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Online Shopping',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
