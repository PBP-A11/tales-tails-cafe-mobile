import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tales_tails_cafe/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _favColorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool passToggle = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.mochiyPopPOne(),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  buildStyledTextField(
                      _usernameController, 'Username', Icons.account_circle),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(
                      _firstNameController, 'First Name', Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(
                      _lastNameController, 'Last Name', Icons.person_outline),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(_emailController, 'Email', Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(_dateOfBirthController, 'Date of Birth',
                      Icons.calendar_today),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(
                      _favColorController, 'Favorite Color', Icons.palette),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(
                      _passwordController, 'Password', Icons.lock,
                      isPassword: true),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStyledTextField(_passwordConfirmationController,
                      'Confirm Password', Icons.lock_outline,
                      isPassword: true),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String firstName = _firstNameController.text;
                      String lastName = _lastNameController.text;
                      String password = _passwordController.text;
                      String favColor = _favColorController.text;
                      String dateOfBirth = _dateOfBirthController.text;
                      String passwordConfirmation =
                          _passwordConfirmationController.text;
                      String email = _emailController.text;

                      if (username.isEmpty ||
                          firstName.isEmpty ||
                          lastName.isEmpty ||
                          email.isEmpty ||
                          favColor.isEmpty ||
                          dateOfBirth.isEmpty ||
                          password.isEmpty ||
                          passwordConfirmation.isEmpty) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text("All fields must be filled")));
                        return;
                      }
                      bool _isValidDate(String date) {
                        RegExp dateRegEx = RegExp(
                          r"^\d{4}-\d{2}-\d{2}$",
                          caseSensitive: false,
                          multiLine: false,
                        );
                        return dateRegEx.hasMatch(date);
                      }

                      if (!_isValidDate(dateOfBirth)) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content:
                                  Text("Date must be in YYYY-MM-DD format")));
                        return;
                      }

                      if (password != passwordConfirmation) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text(
                                  "The two password fields didn’t match.")));
                        return;
                      }
                      // Cek kredensial
                      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                      // Untuk menyambungkan Android emulator dengan Django pada localhost,
                      // gunakan URL http://10.0.2.2/
                      final response = await request
                          .post("http://127.0.0.1:8000/auth/register/", {
                        'username': username,
                        'first_name': firstName,
                        'last_name': lastName,
                        'password1': password,
                        'email': email,
                        'fav_color': favColor,
                        'date_of_birth': dateOfBirth,
                      });

                      if (response['status']) {
                        String message = response['message'];

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text(message)));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Register Gagal'),
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
                    child: const Text('Register',
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a Member?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 200, 90, 53),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
        filled: true, // Enable filling color
        fillColor: Color.fromARGB(255, 240, 229, 210),
        hintText: label,
        labelText: label,
        labelStyle:
            TextStyle(color: Colors.brown), // Set the label text color to brown
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
