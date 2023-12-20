import 'package:flutter/material.dart';
import 'package:tales_tails_cafe/widgets/edit_user.dart';
import 'package:google_fonts/google_fonts.dart';
 // Sesuaikan path dengan lokasi file

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text(
                'Change Username',
                
                style: GoogleFonts.mochiyPopPOne(
                  fontSize: 20,
                  color: Colors.brown
                ),
            ),
           backgroundColor: Color.fromARGB(255, 240, 229, 210),
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
      body: EditUserProfilePage()
        );
  }
}
