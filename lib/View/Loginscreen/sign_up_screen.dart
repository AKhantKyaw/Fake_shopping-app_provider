import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app_with_provider/Component/coustomsnackbar.dart';
import 'package:shopping_app_with_provider/Component/logincontainercurve.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/errorheldaling.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/usersignupandsignIn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  UserAuthentication userAuthentication = UserAuthentication();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwardController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final fbKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff81CACF),
      appBar: AppBar(
        centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Shopping',
            style: TextStyle(fontSize: 20, color: Colors.black),
          )),
      body: Form(
        key: fbKey,
        child: Column(
          children: [
            Expanded(
                child: ClipPath(
              clipper: CurveClipper(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Hello Sign Up',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                color: Colors.white,
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
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      suffixIcon: Icon(Icons.person),
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: 'Your Name'),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      suffixIcon: Icon(Icons.email_outlined),
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: 'Enter your email'),
                                ),
                                TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: passwardController,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        suffixIcon: Icon(Icons.visibility),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: 'Enter  passward')),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                50)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.teal),
                                        elevation:
                                            MaterialStateProperty.all(2)),
                                    onPressed: () async {
                                      if (fbKey.currentState!.validate()) {
                                        Loader.show(context,
                                            progressIndicator:
                                                const SpinKitFadingCircle(
                                              color: Colors.red,
                                            ));
                                        final status = await userAuthentication
                                            .createAccount(
                                          email: emailController.text,
                                          name: nameController.text,
                                          password: passwardController.text,
                                        );
                                        if (status == AuthStatus.successful) {
                                          Loader.hide();
                                          CustomSnackBar.showSuccessSnackBar(
                                              context,
                                              message:
                                                  'Your account create successful');
                                        } else {
                                          Loader.hide();
                                          final error = AuthExceptionHandler
                                              .generateErrorMessage(status);
                                          CustomSnackBar.showErrorSnackBar(
                                            context,
                                            message: error,
                                          );
                                        }
                                      }
                                    },
                                    child: const Text('Sign Up')),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Text("You have account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  color: const Color(0xff81CACF),
                ))
          ],
        ),
      ),
    );
  }
}
