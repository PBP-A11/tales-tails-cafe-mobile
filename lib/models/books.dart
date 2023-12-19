// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Model model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String author;
    String previewLink;
    String description;
    String category;
    String rating;
    bool isBorrowed;
    dynamic borrower;
    String datePublished;
    String imageLink;

    Fields({
        required this.title,
        required this.author,
        required this.previewLink,
        required this.description,
        required this.category,
        required this.rating,
        required this.isBorrowed,
        required this.borrower,
        required this.datePublished,
        required this.imageLink,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        previewLink: json["preview_link"],
        description: json["description"],
        category: json["category"],
        rating: json["rating"],
        isBorrowed: json["is_borrowed"],
        borrower: json["borrower"],
        datePublished: json["date_published"],
        imageLink: json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "preview_link": previewLink,
        "description": description,
        "category": category,
        "rating": rating,
        "is_borrowed": isBorrowed,
        "borrower": borrower,
        "date_published": datePublished,
        "image_link": imageLink,
    };
}

enum Model {
    CATALOG_BOOK
}

final modelValues = EnumValues({
    "catalog.book": Model.CATALOG_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
