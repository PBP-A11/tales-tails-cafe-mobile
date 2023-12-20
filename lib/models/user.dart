// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    String model;
    int pk;
    Fields fields;

    User({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String password;
    DateTime? lastLogin;
    bool isSuperuser;
    bool isStaff;
    bool isActive;
    DateTime dateJoined;
    String userType;
    String firstName;
    String lastName;
    String username;
    String email;
    DateTime dateOfBirth;
    String favColor;
    List<dynamic> groups;
    List<dynamic> userPermissions;

    Fields({
        required this.password,
        required this.lastLogin,
        required this.isSuperuser,
        required this.isStaff,
        required this.isActive,
        required this.dateJoined,
        required this.userType,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.dateOfBirth,
        required this.favColor,
        required this.groups,
        required this.userPermissions,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        password: json["password"],
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        userType: json["user_type"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        favColor: json["fav_color"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "is_superuser": isSuperuser,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "user_type": userType,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "fav_color": favColor,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    };
}
