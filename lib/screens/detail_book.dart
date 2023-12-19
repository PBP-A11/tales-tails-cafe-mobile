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
        title: Text('Book Details'),
      ),
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
            // Text(
            //   'Platform: ${product.fields.platform}',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
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
            Text(
              '${product.fields.isBorrowed}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            // Text(
            //   'Jumlah: ${product.fields.amount}',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'Harga: ${product.fields.price}',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // Display other details similarly...
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      final response = await request.get(
                          "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/book-borrowed-flutter/${product.pk}");
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Buku berhasil dipinjam"),
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()),
                        );
                      } else if (response['status'] == 'error') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Buku sedang tidak tersedia saat ini"),
                        ));
                        Navigator.pushReplacement(
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
                    },
                    child: const Text("Borrow Book"))),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
