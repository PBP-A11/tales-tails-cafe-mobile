// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    int pk;
    String model;
    Fields fields;

    User({
        required this.pk,
        required this.model,
        required this.fields,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        model: json["model"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "model": model,
        "fields": fields.toJson(),
    };
}

class Fields {
    String userType;
    String firstName;
    String lastName;
    String username;
    String email;
    DateTime dateOfBirth;
    String password;

    Fields({
        required this.userType,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.dateOfBirth,
        required this.password,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        userType: json["user_type"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "user_type": userType,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "password": password,
    };
}
