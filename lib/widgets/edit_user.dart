import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/screens/profile_page.dart';


class EditUserProfilePage extends StatefulWidget {
    const EditUserProfilePage({super.key});

    @override
    State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
    final _formKey = GlobalKey<FormState>();
    String _username = "";
    

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();

        return 
        Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 157, 0),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 240, 229, 210),
                                  hintText: "Username",
                                  labelText: "Username",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.brown, width: 4.0),
                                ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.brown, width: 2.0), // Warna saat difokuskan
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person, // Ganti dengan ikon yang sesuai
                                    color: Colors.brown, // Warna ikon
                                  ),
                                ),
                                onChanged: (String? value) {
                                setState(() {
                                    _username = value!;
                                });
                                },
                                validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return "Username tidak boleh kosong!";
                                }
                                return null;
                                },
                            ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      width: 200,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 240, 229, 210),
                                            side: BorderSide(color: Colors.brown, width: 2),
                                          ),      
                                            onPressed: () async {
                                              if (_formKey.currentState!.validate()) {
                                                  // Kirim ke Django dan tunggu respons
                                                  final response = await request.postJson(
                                                  "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/user_profile/edit-profile-user/",
                                                  jsonEncode(<String, String>{
                                                      'username': _username,
                                                  }));
                                                  if (response['status'] == 'success') {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(const SnackBar(
                                                      content: Text("Profile Saved!"),
                                                      ));
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => UserProfilePages()),
                                                      );
                                                  } else {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(const SnackBar(
                                                          content:
                                                              Text("Username sudah dipakai."),
                                                      ));
                                                  }
                                              }
                                          },
                                          child: const Text(
                                              "Save",
                                              style: TextStyle(color: Colors.black),
                                          ),
                                      ),
                                    ),
                                ),
                            ),
                        ]
                      )
            ),
          ),
        );
    }
}