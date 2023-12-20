import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/screens/addbook_forms.dart';
import 'package:tales_tails_cafe/screens/admin_profile.dart';
import 'package:tales_tails_cafe/screens/login.dart';
import 'package:tales_tails_cafe/screens/mybook.dart';
import 'package:tales_tails_cafe/screens/profile_page.dart';
import 'package:tales_tails_cafe/widgets/book_card.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'package:tales_tails_cafe/screens/catalog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/widgets/bottom_nav.dart';


class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

   List<ShopItem> get items {
    // Change to a getter
    if (loggedIn) {
      if (isAdmin){
        return [
        ShopItem("Catalog", Icons.book),
        ShopItem("Add Book", Icons.dashboard_customize),
        ShopItem("List Member", Icons.people),
        ShopItem("Logout", Icons.logout),
      ];
      }
      return [
        ShopItem("Catalog", Icons.book),
        ShopItem("My Books", Icons.bookmark_border),
        ShopItem("Logout", Icons.logout),
      ];
    } else if(loggedIn){
      return [
        ShopItem("Catalog", Icons.book),
        ShopItem("Lihat Buku", Icons.add_shopping_cart),
        ShopItem("Logout", Icons.logout),
        ShopItem("Profile", Icons.park_sharp)
      ];
    } else {
      return [
        ShopItem("Catalog", Icons.checklist),
        ShopItem("Login", Icons.login),
        ShopItem("Profile", Icons.park_sharp)
      ];
    }
  }


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tales & Tails Cafe',
          style: TextStyle(
            color: Color.fromRGBO(114, 78, 43, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 240, 229, 210),
        foregroundColor: Color.fromRGBO(114, 78, 43, 1),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0), // Tinggi garis bawah AppBar
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.brown,
                        width: 4))), // Ubah warna garis sesuai keinginan
          ),
        ),
      ),
      //drawer: LeftDrawer(),
      //bottomNavigationBar: BottomNav(),
      backgroundColor: Color.fromRGBO(243, 155, 0, 1),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Passion for Books\n Purrfection for Cats', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(114, 78, 43, 1),
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(114, 78, 43, 1), // Set the border color here
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Material(
        color: Color.fromARGB(255, 240, 229, 210),
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: InkWell(
          // Area responsive terhadap sentuhan
          onTap: () async {
            // Memunculkan SnackBar ketika diklik
            
            if (item.name == "My Books") {
            Navigator.push(context,

                MaterialPageRoute(builder: (context) => MyBookPage(username: usn))); //gimana cara ambil usernya
            }
            if (item.name == "Add Book") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BookFormPage()));
            } else if (item.name == "Catalog") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BottomNav(initialIndex: 2,)));
            } else if (item.name == "List Member") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BottomNav(initialIndex: 3,)));
            } else if (item.name == "Login") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            } else if (item.name == "Logout") {
              final response =
                  await request.logout("https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/auth/logout/");
              String message = response["message"];
              loggedIn = false;
              isAdmin = false;
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 0)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
            }
          },
          child: Container(
            // Container untuk menyimpan Icon dan Text
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    color: Color.fromRGBO(114, 78, 43, 1),
                    size: 30.0,
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color.fromRGBO(114, 78, 43, 1)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Color getColorDependsItem(String itemName) {
  if (itemName == "Lihat Item") {
    return Colors.blue;
  } else if (itemName == "Tambah Item") {
    return Colors.grey;
  } else if (itemName == "Logout") {
    return Colors.red;
  }
  return Colors.black;
}