
import 'package:ecommerceapiapp/screen/bottom_nav/category_page.dart';
import 'package:ecommerceapiapp/screen/bottom_nav/order_page.dart';
import 'package:ecommerceapiapp/screen/bottom_nav/product_page.dart';
import 'package:ecommerceapiapp/screen/bottom_nav/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    OrderPage(),
    CategoryPage(),
    ProductPage(),
    ProfilePage()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.green,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                   iconColor:Colors.red,
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  iconColor:Colors.red,
                  icon: Icons.category,
                  text: 'Category',
                ),
                GButton(
                  iconColor:Colors.red,
                  icon: Icons.production_quantity_limits,
                  text: 'Product',
                ),
                GButton(
                  iconColor:Colors.red,
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}