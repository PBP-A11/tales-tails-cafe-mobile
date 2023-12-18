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
    String _firstName = "";
    String _lastName = "";
    

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
                                    hintText: "First Name",
                                    labelText: "First Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    ),
                                    onChanged: (String? value) {
                                    setState(() {
                                        _firstName = value!;
                                    });
                                    },
                                    validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                        return "Nama tidak boleh kosong!";
                                    }
                                    return null;
                                    },
                                ),
                                ),
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                    hintText: "Last Name",
                                    labelText: "Last Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    ),
                                    onChanged: (String? value) {
                                    setState(() {
                                        _lastName = value!;
                                    });
                                    },
                                    validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                        return "Nama tidak boleh kosong!";
                                    }
                                    return null;
                                    },
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
                                                    "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/user_profile/edit-profile-admin/",
                                                    jsonEncode(<String, String>{
                                                        'first_name': _firstName,
                                                        'last_name': _lastName,
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