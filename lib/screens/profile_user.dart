import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/models/user_profile.dart';
import 'package:tales_tails_cafe/screens/edit_user_profile.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'dart:convert';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Future<UserProfile> fetchProduct(request) async {
    var response = await request.get(
      'https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/user_profile/get-user/',
    );

    // print(response);
    // melakukan decode response menjadi bentuk json
    UserProfile userData = UserProfile.fromJson(response);

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          
          title: const Text('User Profile'),
        ),
        drawer: const LeftDrawer(),
        body: Container(
            child: FutureBuilder(
                future: fetchProduct(request),
                 builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                    } else {
                        if (!snapshot.hasData) {
                        return const Column(
                            children: [
                            Text(
                                "Tidak ada data buku.",
                                style:
                                    TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                            ],
                        );
                    } else {
                      return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Username: ${snapshot.data!.username}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Email: ${snapshot.data!.email}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "DOB: ${snapshot.data!.dateOfBirth.toIso8601String().substring(0, 10)}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditUserProfilePage(),
                                          ));
                                      }, 
                                      child: Text("Edit Profile"))
                                  ],
                                ),
                              );

                }}})));
  }
}