import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/widgets/bottom_nav.dart';
import 'dart:convert';
import 'package:tales_tails_cafe/widgets/left_drawer.dart';
import 'package:tales_tails_cafe/models/user.dart';

class MemberListPage extends StatefulWidget {
    const MemberListPage({Key? key}) : super(key: key);

    @override
    _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
Future<List<User>> fetchMember() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/user_profile/show-user/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Member
    List<User> list_Member = [];
    for (var d in data) {
        if (d != null) {
            list_Member.add(User.fromJson(d));
        }
    }
    return list_Member;
}

@override
Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
  return Scaffold(
    appBar: AppBar(
      title: const Text('Member'),
    ),
    //drawer: const LeftDrawer(),
    body: FutureBuilder(
      future: fetchMember(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Column(
              children: [
                Text(
                  "Tidak ada data member.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${snapshot.data![index].fields.firstName}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("${snapshot.data![index].fields.userType}"),
                    const SizedBox(height: 10),
                    Text("${snapshot.data![index].fields.email}"),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final response = await request.postJson(
                            "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/mybooks/promote-to-admin-flutter/",
                            jsonEncode(<String, String>{
                                'email': snapshot.data![index].fields.email,
                            })
                            );
                            if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                content: Text("Berhasil mengubah role!"),
                                ));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 3,)),
                                );
                            } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content:
                                        Text("Terdapat kesalahan, silakan coba lagi."),
                                ));
                            }

                          },
                          child: Text('Change Role'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    ),
  );
}

}