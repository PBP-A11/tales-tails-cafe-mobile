// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:tales_tails_cafe/screens/catalog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tales_tails_cafe/screens/login.dart';

class DetailGame extends StatelessWidget {
  final Product product;

  DetailGame({required this.product});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Details',
          style: GoogleFonts.mochiyPopPOne(),
          ),
        backgroundColor: Color.fromARGB(255, 240, 229, 210),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Center(
                child: Image.network(
              "${product.fields.imageLink}",
              height: 200,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Text(
                  "Image not available",
                  style: GoogleFonts.poppins(),
                );
              },
            )),
            SizedBox(height: 20),
            const Text(
              "Judul",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${product.fields.title}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${product.fields.category}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${product.fields.description}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            // Text(
            //   '${product.fields.isBorrowed}',
            //   style: TextStyle(
            //     fontSize: 18,
            //   ),
            // ),
            SizedBox(height: 20),
            Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 240, 229, 210),
                      side: BorderSide(color: Colors.brown, width: 2),
                    ),      
                    onPressed: () async {
                      if (isAdmin && loggedIn){
                        final response = await request.get(
                            "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/delete-book-flutter/${product.pk}");
                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Buku berhasil dihapus"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage()),
                              );
                            } else if (response['status'] == 'error') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Buku tidak ditemukan"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage()),
                              );
                            }
                      }
                     else if (loggedIn){
                      final response = await request.get(
                          "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/book-borrowed-flutter/${product.pk}");
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Buku berhasil dipinjam"),
                        ));
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()),
                        );
                      } else if (response['status'] == 'error') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Buku sedang tidak tersedia saat ini"),
                        ));
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                    }
                    },
                    child: Text(
                      isAdmin && loggedIn ? "Delete" : "Borrow book",
                      style: TextStyle(color: Colors.black),
                      ))),
            SizedBox(height: 20),
            // Center(
            //     child: ElevatedButton(
            //         onPressed: () async {
            //           final response = await request.get(
            //               "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/delete-book-flutter/${product.pk}");
            //           if (response['status'] == 'success') {
            //             ScaffoldMessenger.of(context)
            //                 .showSnackBar(const SnackBar(
            //               content: Text("Buku berhasil dihapus"),
            //             ));
            //             Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => ProductPage()),
            //             );
            //           } else if (response['status'] == 'error') {
            //             ScaffoldMessenger.of(context)
            //                 .showSnackBar(const SnackBar(
            //               content: Text("Buku tidak ditemukan"),
            //             ));
            //             Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => ProductPage()),
            //             );
            //           } else {
            //             Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(builder: (context) => LoginPage()),
            //             );
            //           }
            //         },
            //         child: const Text("Delete Book"))),
            //         SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
