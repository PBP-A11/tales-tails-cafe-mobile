// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:http/http.dart' as http;
import 'package:tales_tails_cafe/screens/login.dart';
import 'package:tales_tails_cafe/screens/mybook.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBooksDetail extends StatelessWidget {
  final Product product;

  MyBooksDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        backgroundColor: Color.fromARGB(255, 240, 229, 210),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.brown, width: 4))),
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
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Text(
                    "Image not available",
                    style: GoogleFonts.poppins(),
                  );
                },
              ),
            ),
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
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 240, 229, 210),
                  side: BorderSide(color: Colors.brown, width: 2),
                ),
                onPressed: () async {
                  final response = await http.get(
                    Uri.parse("https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/mybooks/book-return-flutter/${product.pk}"),
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
                child: const Text(
                  "Return Book",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
