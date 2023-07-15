import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Component/coustomsnackbar.dart';
import 'package:shopping_app_with_provider/Component/logincontainercurve.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/errorheldaling.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/usersignupandsignIn.dart';
import 'package:shopping_app_with_provider/View/HomeScreen/homescreen.dart';
import 'package:shopping_app_with_provider/View/Loginscreen/forgotscreen.dart';
import 'package:shopping_app_with_provider/View/Loginscreen/sign_up_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  UserAuthentication userAuthentication = UserAuthentication();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwardController = TextEditingController();
  CustomSnackBar customSnackBar = CustomSnackBar();
  bool obscureText = true;
  final fbKey = GlobalKey<FormState>();

 
  void _toggle() {
    setState(() {
      obscureText =!obscureText;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailController>(context);
    return Form(
      key: fbKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Shopping',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        backgroundColor: const Color(0xff81CACF),
        body: Column(
          children: [
            Expanded(
                child: ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                        height: 150,
                        child: Image.asset('images/icons8-login-100.png')),
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            )),
            Expanded(
                flex: 2,
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  ' HELLO SIGN IN ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      suffixIcon: Icon(Icons.email_outlined),
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: 'Enter your email'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  obscureText: obscureText,
                                  controller: passwardController,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      hintText: 'Enter  passward'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    _toggle();
                                  },
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const Forgotpassward();
                                          }));
                                        },
                                        child: const Text(
                                          'Forgot Passward ?',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ))),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.teal),
                                  elevation: MaterialStateProperty.all(2)),
                              onPressed: () async {
                                if (fbKey.currentState!.validate()) {
                                  Loader.show(context,
                                      progressIndicator:
                                          const SpinKitFadingCircle(
                                        color: Colors.red,
                                      ));
                                  final status = await userAuthentication.login(
                                      email: emailController.text,
                                      password: passwardController.text);
                                  if (status == AuthStatus.successful) {
                                    Loader.hide();
                                    provider.setprefesbool();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                        (route) => false);
                                  } else {
                                    Loader.hide();
                                    final error = AuthExceptionHandler
                                        .generateErrorMessage(status);
                                    CustomSnackBar.showErrorSnackBar(context,
                                        message: error);
                                  }
                                }
                              },
                              child: const Text('Sign In')),
                          const SizedBox(
                            height: 40,
                            width: 20,
                          ),
                          Row(
                            children: [
                              const Text("Don't have account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const SignupScreen();
                                    }));
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  color: const Color(0xff81CACF),
                )),
          ],
        ),
      ),
    );
  }
}
