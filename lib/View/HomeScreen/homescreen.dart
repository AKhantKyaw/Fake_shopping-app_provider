import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_with_provider/View/HomeScreen/favoratescreen.dart';
import 'package:shopping_app_with_provider/View/HomeScreen/products_list.dart';
import 'package:shopping_app_with_provider/View/HomeScreen/profile.dart';
import 'package:shopping_app_with_provider/View/ShoppingScreen/shopping_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? currentindex;
  final List<Widget> witgetoption = [
    const ProductsList(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    currentindex = 0;
    super.initState();
  }

  onChange(int? index) {
    setState(() {
      currentindex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA6D1E6),
      body: witgetoption[currentindex!],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const ShoppingCart();
          })));
        },
        // child: Badge(
        //   badgeColor: Colors.orange,
        //   badgeContent: Text(context.read<DetailController>().cart.length.toString()),
        //   child: const Icon(
        //     Icons.shopping_bag,
        //     color: Colors.black,
        //   ),
        //   position: BadgePosition.topEnd(top: -25, end: -20),
        // ),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentindex,
        onTap: onChange,
        hasNotch: true,
        hasInk: true,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        fabLocation: BubbleBottomBarFabLocation.end,
        inkColor: Colors.black12,
        items: const <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.teal,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.deepPurple,
              ),
              title: Text("Favorite")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.personal_injury,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.indigo,
              ),
              title: Text("Profile")),
        ],
      ),
    );
  }
}
