import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:tales_tails_cafe/screens/review_screen.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'package:tales_tails_cafe/screens/detail_book.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> futureProducts;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProduct();
  }

  Future<List<Product>> fetchProduct() async {
    var url = Uri.parse('https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/get-books/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

    List<Product> searchProducts(String text, List<Product> products) {
    if (text.isEmpty) {
      return products;
    }
    return products
        .where((product) =>
            product.fields.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Catalog',
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
      //drawer: const LeftDrawer(),
      backgroundColor: Color.fromARGB(255, 241, 157, 0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 240, 229, 210),
                filled: true,
                hintText: 'Search by title...',
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.brown, width: 4.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada data produk.'));
                } else {
                  List<Product> searchedProducts = searchProducts(searchText, snapshot.data!);
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Menampilkan 2 kolom
                        childAspectRatio: MediaQuery.of(context).size.width/650,
                        crossAxisSpacing: 8.0, // Spasi horizontal antara item
                        mainAxisSpacing: 8.0, // Spasi vertikal antara item
                      ),
                      itemCount: searchedProducts.length,
                      itemBuilder: (context, index) {
                        Product product = searchedProducts[index];
                        return GestureDetector(
                          onTap: () {
                            // // Navigasi ke halaman detail
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailGame(product: product),
                            //   ),
                            // );
                            // Navigasi ke halaman detail
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.brown),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                              ),
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfffefadd),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    border: Border.all(color: Colors.brown, width: 5),
                                  ),
                                  height: 200,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailGame(product: product),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 125,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.brown, width: 2),
                                            ),
                                            child: Center(child: Text("Details")),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewScreen(product: product),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 125,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.brown, width: 2),
                                            ),
                                            child: Center(child: Text("Review")),
                                          ),
                                        ),
                                      ]),
                                );
                              },
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
                                    product.fields.imageLink,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    product.fields.title,
                                    style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                          ),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    product.fields.author,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.0
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    product.fields.isBorrowed ? 'Not Available' : 'Available',
                                    style: GoogleFonts.mochiyPopPOne(
                                      textStyle : TextStyle(
                                      fontSize: 10.0,
                                      color: product.fields.isBorrowed ? Colors.red : Colors.green,
                                      ),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}