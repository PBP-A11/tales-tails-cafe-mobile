import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:tales_tails_cafe/screens/catalog.dart';
import 'package:tales_tails_cafe/screens/list_product.dart';

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
            SizedBox(height: 10),
            Text(
              "Judul: ${product.fields.title}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${product.fields.category}',
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
            Text(
              'Deskripsi: ${product.fields.description}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
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
            ElevatedButton(
                onPressed: () async {
                  final response = await http.post(
                      Uri.parse("http://127.0.0.1:8000/catalog/book-borrowed-flutter/${product.pk}"));
                      if (response.statusCode == 200){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                        content: Text("Produk baru berhasil disimpan!"),
                        ));
                         Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ProductPage()),
                        );

                      }
                },
                child: const Text("Borrow Book"))
          ],
        ),
      ),
    );
  }
}
