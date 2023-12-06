import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/models/books.dart';

class DetailGame extends StatelessWidget {
  final Product product;

  DetailGame({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Details'),
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
          ],
        ),
      ),
    );
  }
}