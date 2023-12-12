import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'package:tales_tails_cafe/screens/detail_book.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductPage extends StatefulWidget {
    const ProductPage({Key? key}) : super(key: key);

    @override
    _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
Future<List<Product>> fetchProduct() async {
    var url = Uri.parse(
        'https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/get-books/');
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
        title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: (){
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DetailGame(product: snapshot.data![index]),
                            ),
                            );
                          },
                        child:Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Image.network(
                                    "${snapshot.data![index].fields.imageLink}",
                                    width: 100,
                                    height: 100,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return Text(
                                        "Image not available",
                                        style: GoogleFonts.mochiyPopPOne(),
                                        );
                                    },
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                    "${snapshot.data![index].fields.title}",
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    snapshot.data![index].fields.isBorrowed ? 'Not Avaible' : 'Avaible',
                                    style: GoogleFonts.mochiyPopPOne(
                                      textStyle : TextStyle(
                                      fontSize: 10.0,
                                      color: snapshot.data![index].fields.isBorrowed ? Colors.red : Colors.green,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  
                                ],
                                ),
                            )
                          )
                            );
                    }
                }
            }));
    }
}