import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tales_tails_cafe/screens/addbook_forms.dart';
import 'package:tales_tails_cafe/screens/admin_profile.dart';
import 'package:tales_tails_cafe/screens/catalog.dart';
import 'package:tales_tails_cafe/screens/list_member.dart';
import 'package:tales_tails_cafe/screens/login.dart';
import 'package:tales_tails_cafe/screens/menu.dart';
import 'package:tales_tails_cafe/screens/profile_page.dart';

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
    UserProfilePages(),
    ProductPage(),
    MemberListPage(),
    BookFormPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (loggedIn) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 4.0, color: Colors.brown), // Atur warna dan lebar sesuai keinginan
        ),
        color: Color.fromARGB(255, 240, 229, 210),
      ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
          child: GNav(
            backgroundColor: Color.fromARGB(255, 240, 229, 210),
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
    } else {
      return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Color.fromRGBO(226, 199, 153, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
          child: GNav(
            backgroundColor: Color.fromRGBO(226, 199, 153, 1),
            color: Color.fromRGBO(154, 59, 59, 1),
            activeColor: Color.fromRGBO(154, 59, 59, 1),
            onTabChange: (value) {
              navigateBar(value);
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
            ],
          ),
        ),
      ),
    );
    }
  }
}
