// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:tales_tails_cafe/screens/detail_mybooks.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'package:google_fonts/google_fonts.dart';


class MyBookPage extends StatefulWidget {
  final String username;

  const MyBookPage({Key? key, required this.username}) : super(key: key);

  @override
  _MyBookState createState() => _MyBookState();
}

class _MyBookState extends State<MyBookPage> {
Future<List<Product>> fetchProduct(String username) async {
    var url = Uri.parse(
        'https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/mybooks/get-mybooks-flutter/$username');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(Product.fromJson(d));
        }
    }
    return list_product;
}

@override
Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('List of Borrowed Books'),
          backgroundColor: Color.fromARGB(255, 240, 229, 210),
          centerTitle: true, // Set this property to true
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
        backgroundColor: Color.fromARGB(255, 241, 157, 0),
        //drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(widget.username),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (snapshot.connectionState == ConnectionState.done) {
  if (snapshot.data.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: double.infinity, // Atur lebar maksimum
                child: Text(
                  "You Borrowed 0 books from this site",
                  textAlign: TextAlign.center, // Pengaturan teks ke tengah
                  style: TextStyle(color: Colors.brown, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
 else {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (_, index) => InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyBooksDetail(product: snapshot.data[index]),
            ),
          );
        },
        child: Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 240, 229, 210),
    border: Border.all(color: Colors.brown, width: 4.0),
    borderRadius: BorderRadius.circular(8.0),
  ),
  margin: const EdgeInsets.all(8.0),
  padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
  child: Image.network(
    snapshot.data[index].fields.imageLink,
    width: 150,
    height: 150,
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      return SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              "Image not available",
              style: GoogleFonts.mochiyPopPOne(),
            ),
          ),
        ),
      );
    },
  ),
),
const SizedBox(height: 12),
Center(
  child: Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 2.0),
    child: Text(
      snapshot.data[index].fields.title,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  ),
),
const SizedBox(height: 4),
Center(
  child: Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 2.0),
    child: Text(
      snapshot.data[index].fields.author,
      style: GoogleFonts.poppins(
        fontSize: 12.0,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  ),
),

          ],
        ),
      ),

      ),
    );
  }
} else {
  return const Center(child: CircularProgressIndicator());
}

                }
            }));
    }
}