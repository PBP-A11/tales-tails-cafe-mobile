import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/screens/admin_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAdminPage extends StatefulWidget {
  const EditAdminPage({super.key});

  @override
  State<EditAdminPage> createState() => _EditAdminPageState();
}

class _EditAdminPageState extends State<EditAdminPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Name',
          style: GoogleFonts.mochiyPopPOne(
              fontSize: 20, color: Color.fromARGB(255, 240, 229, 210)),
        ),
        backgroundColor: Color.fromARGB(255, 200, 90, 53),
        foregroundColor: Color.fromARGB(255, 240, 229, 210),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0), // Tinggi garis bawah AppBar
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.brown,
                        width: 4))), // Ubah warna garis sesuai keinginan
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 240, 229, 210),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                buildTextField(
                    'First Name', Icons.person, (value) => _firstName = value),
                SizedBox(height: 10),
                buildTextField(
                    'Last Name', Icons.person, (value) => _lastName = value),
              ],
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
                          MaterialPageRoute(
                              builder: (context) => AdminProfilePage()),
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
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}

TextFormField buildTextField(
    String label, IconData icon, Function(String) onSaved) {
  return TextFormField(
    decoration: InputDecoration(
      hintText: label,
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.brown, width: 4.0)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.brown, width: 2.0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.brown, width: 2.0)),
      prefixIcon: Icon(icon, color: Colors.brown),
    ),
    onChanged: (value) => onSaved(value),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "$label cannot be empty";
      }
      return null;
    },
  );
}