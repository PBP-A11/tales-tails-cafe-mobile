// // To parse this JSON data, do
// //
// //     final product = productFromJson(jsonString);

// import 'dart:convert';

// List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

// String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Product {
//     String model;
//     int pk;
//     Fields fields;

//     Product({
//         required this.model,
//         required this.pk,
//         required this.fields,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         model: json["model"],
//         pk: json["pk"],
//         fields: Fields.fromJson(json["fields"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "model": model,
//         "pk": pk,
//         "fields": fields.toJson(),
//     };
// }

// class Fields {
//     int user;
//     String name;
//     DateTime dataAdded;
//     int amount;
//     String description;
//     int price;
//     String category;
//     String platform;

//     Fields({
//         required this.user,
//         required this.name,
//         required this.dataAdded,
//         required this.amount,
//         required this.description,
//         required this.price,
//         required this.category,
//         required this.platform,
//     });

//     factory Fields.fromJson(Map<String, dynamic> json) => Fields(
//         user: json["user"],
//         name: json["name"],
//         dataAdded: DateTime.parse(json["data_added"]),
//         amount: json["amount"],
//         description: json["description"],
//         price: json["price"],
//         category: json["category"],
//         platform: json["platform"],
//     );

//     Map<String, dynamic> toJson() => {
//         "user": user,
//         "name": name,
//         "data_added": "${dataAdded.year.toString().padLeft(4, '0')}-${dataAdded.month.toString().padLeft(2, '0')}-${dataAdded.day.toString().padLeft(2, '0')}",
//         "amount": amount,
//         "description": description,
//         "price": price,
//         "category": category,
//         "platform": platform,
//     };
// }