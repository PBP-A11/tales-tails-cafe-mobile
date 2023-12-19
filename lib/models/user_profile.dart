// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    String firstName;
    String lastName;
    String username;
    String email;
    DateTime dateOfBirth;
    String userType;

    UserProfile({
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.dateOfBirth,
        required this.userType,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        userType: json["user_type"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "user_type": userType,
    };
}
