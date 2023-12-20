import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/models/user_profile.dart';
import 'package:tales_tails_cafe/screens/edit_user_profile.dart';
import 'package:tales_tails_cafe/screens/menu.dart';
import 'package:tales_tails_cafe/screens/mybook.dart';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'package:tales_tails_cafe/screens/login.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';


class UserProfilePages extends StatefulWidget {
  const UserProfilePages({Key? key}) : super(key: key);

  @override
  _UserProfilePagesState createState() => _UserProfilePagesState();
}

class _UserProfilePagesState extends State<UserProfilePages> {
  Future<UserProfile> fetchUserProfile(request) async {
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
        title: Text(
          'Profile',
          style: GoogleFonts.mochiyPopPOne(
            fontSize: 20,
            color: Colors.brown,
            )
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
      backgroundColor: Color.fromARGB(255, 241, 157, 0),
      //drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder<UserProfile>(
            future: fetchUserProfile(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data user.",
                        style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                }
                UserProfile userProfile = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            // Use userProfile.imageURL or the appropriate property to display the user's image
                            "https://cdn.discordapp.com/attachments/1020531071479201793/1186512534379954239/-_LIPPS_hair_MENS_HAIRSTYLE__.jpg?ex=659384e8&is=65810fe8&hm=dce9e40046a1430d99176308a9901fd61bccae459188c2ecdab4772a4f5a0333&",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://cdn.discordapp.com/attachments/1020531071479201793/1186512367551520798/man.png",
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '${snapshot.data!.username}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.email), // Icon email
                        SizedBox(width: 8), // Spasi antara ikon dan teks
                        Text(
                          '${snapshot.data!.email}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => EditUserProfilePage())
                            );
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(239, 240, 229, 210),
                          side: BorderSide(color: Colors.brown, width: 2),
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ) 
                        ),
                    ),
                  const SizedBox(height: 30),
                  ListTile(
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyBookPage(username: '${snapshot.data!.username}')), // Ganti dengan halaman yang diinginkan
                    );
                  },
                    leading: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.brown,
                          width: 1
                        ),
                        color: Color.fromARGB(239, 240, 229, 210),
                      ),
                      child: Icon(Icons.book),
                    ),
                    title: Text(
                      "My Book"
                    ),
                    trailing: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.brown,
                          width: 1
                        ),
                        color: Color.fromARGB(239, 240, 229, 210),
                      ),
                      child: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.brown,),
                    ),
                  ),
                  const SizedBox(height:2),
                  ListTile(
                    onTap: () async {
                    final response =
                  await request.logout("https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/auth/logout/");
                  String message = response["message"];
                  loggedIn = false;
                  isAdmin = false;
                  if (response['status']) {
                    String uname = response["username"];
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$message Sampai jumpa, $uname."),
                    ));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$message"),
                    ));
                  } 
                  },
                    leading: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.brown,
                          width: 1
                        ),
                        color: Color.fromARGB(239, 240, 229, 210),
                      ),
                      child: Icon(Icons.exit_to_app),
                    ),
                    title: Text(
                      "Logout"
                    ),
                    trailing: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.brown,
                          width: 1
                        ),
                        color: Color.fromARGB(239, 240, 229, 210),
                      ),
                      child: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.brown),
                    ),
                  )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
