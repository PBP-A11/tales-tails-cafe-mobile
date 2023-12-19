import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tales_tails_cafe/screens/catalog.dart';
import 'package:tales_tails_cafe/screens/list_member.dart';
import 'package:tales_tails_cafe/screens/menu.dart';
import 'package:tales_tails_cafe/screens/profile_page.dart';
import 'package:tales_tails_cafe/screens/profile_user.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex;

  const BottomNav({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void navigateBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    MyHomePage(),
    UserProfilePage(),
    ProductPage(),
    MemberListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Color.fromRGBO(226, 199, 153, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 2, 80, 2),
          child: GNav(
            backgroundColor: Color.fromRGBO(226, 199, 153, 1),
            color: Color.fromRGBO(154, 59, 59, 1),
            activeColor: Color.fromRGBO(154, 59, 59, 1),
            gap: 20,
            onTabChange: (value) {
              navigateBar(value);
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.face,
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
