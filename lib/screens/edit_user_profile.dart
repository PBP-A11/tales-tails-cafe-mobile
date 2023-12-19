import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/screens/profile_user.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';


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
        appBar: AppBar(
            title: const Center(
            child: Text(
                'Edit Admin',
            ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                    hintText: "Username",
                                    labelText: "Username",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    ),
                                    onChanged: (String? value) {
                                    setState(() {
                                        _username = value!;
                                    });
                                    },
                                    validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                        return "Nama tidak boleh kosong!";
                                    }
                                    return null;
                                    },
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
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(Colors.indigo),
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
                                                            MaterialPageRoute(builder: (context) => UserProfilePage()),
                                                        );
                                                    } else {
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(const SnackBar(
                                                            content:
                                                                Text("Terdapat kesalahan, silakan coba lagi."),
                                                        ));
                                                    }
                                                }
                                            },
                                            child: const Text(
                                                "Save",
                                                style: TextStyle(color: Colors.white),
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