import 'package:tales_tails_cafe/screens/menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:tales_tails_cafe/widgets/bottom_nav.dart';
import 'package:tales_tails_cafe/screens/register.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const LoginApp());
}

bool loggedIn = false;
bool isAdmin = false;
String usn = "";

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passToggle = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.mochiyPopPOne(),
        ),
        backgroundColor: Color.fromARGB(255, 240, 229, 210),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.brown,
                        width: 4))),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 241, 157, 0),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                  const SizedBox(height: 30),
                  buildStyledTextField(
                    _usernameController, 'Username', Icons.person
                  ),
                  const SizedBox(height: 20),
                  buildStyledTextField(
                    _passwordController, 'Password', Icons.lock, isPassword: true
                  ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                // gunakan URL http://10.0.2.2/
                final response = await request.login(
                    "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/auth/login/",
                    {
                      'username': username,
                      'password': password,
                    });

                if (request.loggedIn) {
                  loggedIn = true;
                  String message = response['message'];
                  String uname = response['username'];
                  usn = uname;
                  if (response['user_type'] == "ADMIN") {
                    isAdmin = true;
                  } else {
                    isAdmin = false;
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNav()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("$message Selamat datang, $uname.")));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(239, 240, 229, 210),
                      side: BorderSide(color: Colors.brown, width: 2),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 15, color: Colors.black)),

            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(color: Color.fromARGB(255, 200, 90, 53)
)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextField buildStyledTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !passToggle : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 240, 229, 210),
        hintText: label,
        labelText: label,
        labelStyle: TextStyle(color: Colors.brown),
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
        suffixIcon: isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    passToggle = !passToggle;
                  });
                },
                child: Icon(
                  passToggle ? Icons.visibility : Icons.visibility_off,
                  color: Colors.brown,
                ),
              )
            : null,
      ),
    );
  }

}
