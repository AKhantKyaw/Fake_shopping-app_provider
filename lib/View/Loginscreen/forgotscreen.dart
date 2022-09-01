import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app_with_provider/Component/coustomsnackbar.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/errorheldaling.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/usersignupandsignIn.dart';

class Forgotpassward extends StatefulWidget {
  const Forgotpassward({Key? key}) : super(key: key);

  @override
  State<Forgotpassward> createState() => _ForgotpasswardState();
}

class _ForgotpasswardState extends State<Forgotpassward> {
  TextEditingController emailcontroller = TextEditingController();
  UserAuthentication userAuthentication = UserAuthentication();
  final fbKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white54,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: fbKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 70),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email address to recover your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
              const  SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        elevation: MaterialStateProperty.all(2)),
                    onPressed: () async {
                      if (fbKey.currentState!.validate()) {
                        Loader.show(context,
                            progressIndicator: const SpinKitFadingCircle(
                              color: Colors.red,
                            ));
                        final status = await userAuthentication.resetPassword(
                            email: emailcontroller.text);
                        if (status == AuthStatus.successful) {
                          Loader.hide();
                          CustomSnackBar.showSuccessSnackBar(context,
                              message: 'please check your email inbox');
                        } else {
                          Loader.hide();
                          final error =
                              AuthExceptionHandler.generateErrorMessage(status);
                          CustomSnackBar.showErrorSnackBar(context,
                              message: error);
                        }
                      }
                    },
                    child: const Text('Sign In')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
