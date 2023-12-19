import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/models/book_review.dart';
import 'package:tales_tails_cafe/models/books.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({required this.product, super.key});
  final Product product;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int? starsReview = null;
  TextEditingController reviewTextfield = TextEditingController();
  bool isEdit = false;
  int? reviewId = null;
  Future<List<BookReview>> fetchReview(CookieRequest request, int id) async {
    // TODO: Ubah url sesuai dengan wishilst
    List<BookReview> reviews = [];

    var response = await request
        .get("http://127.0.0.1:8000/review/get_book_reviews_json/$id/");

    print(response);
    // konversi json menjadi object Product
    for (var d in response['book_review']) {
      if (d != null) {
        reviews.add(BookReview.fromJson(d));
      }
    }
    print(reviews);
    return reviews;
  }

  Future<void> addReview(
      CookieRequest request, int id, int stars, String content) async {
    print(stars);
    print(content);
    var response = await request.post(
      "http://127.0.0.1:8000/review/add_book_reviews_json/$id/",
      jsonEncode(
        {"stars": stars.toString(), "content": content},
      ),
    );

    setState(() {});

    if (response['status'] == true) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Berhasil menambahkan review")));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Gagal menambahkan review")));
    }
    print(response);
  }

  Future<void> editReview(
      CookieRequest request, int id, int stars, String content) async {
    print(stars);
    print(content);
    var response = await request.post(
      "http://10.0.2.2:8000/review/edit_book_reviews_json/$id/",
      jsonEncode(
        {"stars": stars.toString(), "content": content},
      ),
    );

    setState(() {});

    if (response['status'] == true) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Berhasil edit review")));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Gagal edit review")));
    }
    print(response);
  }

  Future<void> deleteReview(
    CookieRequest request,
    int id,
  ) async {
    var response = await request
        .post("http://10.0.2.2:8000/review/delete_book_reviews_json/$id/", {});

    setState(() {});

    if (response['status'] == true) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Berhasil delete review")));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Gagal delete review")));
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Color(0xfff39b00),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xfffefadd),
        centerTitle: true,
        title: const Text(
          'Review',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.brown,
            height: 4.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: FutureBuilder(
                  future: fetchReview(request, widget.product.pk),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.brown,
                        ),
                      );
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Text("Belum ada review..."),
                        );
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.brown, width: 4),
                              color: Color(0xfffefadd),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data![index].user!,
                                        style: TextStyle(
                                            color: Colors.brown,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      PopupMenuButton(
                                          icon: Icon(
                                            Icons.more_vert_rounded,
                                            color: Colors.brown,
                                          ),
                                          color: Color(0xfffefadd),
                                          onSelected: (String choice) {
                                            if (choice == 'Edit') {
                                              setState(() {
                                                starsReview =
                                                    snapshot.data![index].stars;
                                                reviewTextfield.text = snapshot
                                                        .data![index].content ??
                                                    "";
                                                reviewId =
                                                    snapshot.data![index].pk;
                                                isEdit = true;
                                              });
                                            } else if (choice == 'Delete') {
                                              deleteReview(request,
                                                  snapshot.data![index].pk!);
                                            }
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return ['Edit', 'Delete']
                                                .map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(
                                                  choice,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              );
                                            }).toList();
                                          }),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data![index].dateAdded!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Stars : ",
                                        style: TextStyle(
                                            color: Colors.brown,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      RatingBarIndicator(
                                        rating: snapshot.data![index].stars!
                                            .toDouble(),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 16.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].content!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
              SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.brown, width: 4),
                  color: Color(0xfffefadd),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        !isEdit ? "Add your review" : "Edit Your Review",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownMenu<int>(
                            initialSelection: starsReview,
                            onSelected: (int? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                starsReview = value!;
                              });
                            },
                            inputDecorationTheme: InputDecorationTheme(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.brown, width: 2),
                                    borderRadius: BorderRadius.circular(15))),
                            menuHeight: 120,
                            width: 150,
                            dropdownMenuEntries:
                                List.generate(5, (index) => index + 1)
                                    .map<DropdownMenuEntry<int>>((int value) {
                              return DropdownMenuEntry<int>(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                      Colors.brown.withOpacity(0.5),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      Color(0xfffefadd),
                                    ),
                                  ),
                                  value: value,
                                  label: value.toString());
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: reviewTextfield,
                            maxLines: 8,
                            style:
                                const TextStyle(height: 1), // Adjust as needed
                            decoration: InputDecoration(
                              labelText: "Your review ...",
                              labelStyle: TextStyle(color: Colors.brown),
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.brown),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          if (starsReview != null) {
                            !isEdit
                                ? addReview(request, widget.product.pk,
                                    starsReview!, reviewTextfield.text)
                                : editReview(request, reviewId ?? -1,
                                    starsReview!, reviewTextfield.text);
                          }
                        },
                        child: Container(
                          width: 125,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xfffefadd),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.brown, width: 3),
                          ),
                          child: Center(child: Text("Submit")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}