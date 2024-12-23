import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/view/cart/cart_page.dart';
import 'package:clean_pro_user/view/order/order_page.dart';
import 'package:clean_pro_user/view/home/widgets/home_content.dart';
import 'package:clean_pro_user/view/profile/new_profile__page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> _buildScreens() {
    return [
      const HomeScrenContent(),
      const CartPage(
        service: "card",
      ),
      OrdersList(),
      const ProfilePage()
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_basket, size: 30, color: Colors.white),
          Icon(Icons.checklist, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: AppColors.actionBlue,
        buttonBackgroundColor: AppColors.actionBlue,
        backgroundColor: AppColors.backgroundGrey,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _buildScreens()[_page],
    );
  }
}
