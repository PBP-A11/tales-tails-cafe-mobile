// To parse this JSON data, do
//
//     final userAdmin = userAdminFromJson(jsonString);

import 'dart:convert';

UserAdmin userAdminFromJson(String str) => UserAdmin.fromJson(json.decode(str));

String userAdminToJson(UserAdmin data) => json.encode(data.toJson());

class UserAdmin {
    String firstName;
    String lastName;
    String username;
    String email;
    DateTime dateOfBirth;
    String userType;
    int id;

    UserAdmin({
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.dateOfBirth,
        required this.userType,
        required this.id,
    });

    factory UserAdmin.fromJson(Map<String, dynamic> json) => UserAdmin(
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        userType: json["user_type"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "user_type": userType,
        "id" : id,
    };
}
