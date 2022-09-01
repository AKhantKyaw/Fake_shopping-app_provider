import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_with_provider/Component/constanttext.dart';
import 'package:shopping_app_with_provider/Controller/DetailController/detailscreencontroller.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/usersignupandsignIn.dart';
import 'package:shopping_app_with_provider/View/Loginscreen/loginscreen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextFileConstant textFileConstant = TextFileConstant();
  UserAuthentication authentication = UserAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA6D1E6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffA6D1E6),
        centerTitle: true,
        title: const Text(
          'Your Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: const Color(0xffA6D1E6),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                  radius: 60,
                  backgroundColor: Colors.black26,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  UserAuthentication.auth.currentUser!.displayName!,
                  style: textFileConstant.titleStyle,
                ),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize:
                        MaterialStateProperty.all(const Size(150, 50))),
                onPressed: () {
                  authentication.logout;
                  Provider.of<DetailController>(context, listen: false)
                      .removebool();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const Loginscreen();
                  }), (route) => false);
                },
                child: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
