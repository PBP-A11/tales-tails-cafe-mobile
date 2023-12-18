// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:http/http.dart' as http;
import 'package:tales_tails_cafe/screens/login.dart';
import 'package:tales_tails_cafe/screens/mybook.dart';

class MyBooksDetail extends StatelessWidget {
  final Product product;

  MyBooksDetail({required this.product});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 10),
            Text(
              'Deskripsi: ${product.fields.description}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(
                  Uri.parse("http://127.0.0.1:8000/mybooks/book-return/${product.pk}"),
                );

                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Buku berhasil dikembalikan!"),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyBookPage(username: usn)),
                  );
                }
              },
              child: const Text("Return Book"),
            )
          ],
        ),
      ),
    );
  }
}
