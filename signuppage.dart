import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panenbawang/LogInPage.dart';
import 'package:panenbawang/frontwidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  bool isCheckedRememberMe = false;
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Regex for email validation
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

  Future<void> _signup() async {
    String email = _emailController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Validations
    if (email.isEmpty ||
        phoneNumber.isEmpty ||
        username.isEmpty ||
        password.isEmpty) {
      _showErrorDialog("Silakan isi semua kolom.");
      return;
    }

    if (!emailRegExp.hasMatch(email)) {
      _showErrorDialog("Format email tidak valid.");
      return;
    }

    if (password.length < 8) {
      _showErrorDialog("Password harus minimal 8 karakter.");
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      _showErrorDialog("Nomor telepon harus berupa angka.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/user.json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null) {
          bool userExists = false;
          responseData.forEach((key, value) {
            if (value['username'] == username || value['email'] == email) {
              userExists = true;
            }
          });

          if (userExists) {
            _showErrorDialog(
                "Username atau email sudah ada. Silakan gunakan yang lain.");
          } else {
            final signupResponse = await http.post(
              url,
              body: json.encode({
                'email': email,
                'phoneNumber': phoneNumber,
                'username': username,
                'password': password,
              }),
            );

            if (signupResponse.statusCode == 200) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInPage(),
                ),
              );
            } else {
              _showErrorDialog("Gagal mendaftar. Silakan coba lagi.");
            }
          }
        } else {
          _showErrorDialog("Gagal memproses data respons.");
        }
      } else {
        _showErrorDialog(
            "Gagal mengambil data dari database. Status kode: ${response.statusCode}");
      }
    } catch (error) {
      _showErrorDialog("Terjadi kesalahan. Silakan coba lagi.");
      print("Failed to add user: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(height: 5.0),
                Center(child: Image.asset('assets/images/logo.png')),
                SizedBox(height: 10.0),
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        filled: true,
                        hintText: "Masukkan Username",
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                        ),
                        fillColor: Color(0xFFF5DCD5),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      filled: true,
                      hintText: "Masukkan Email",
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.email),
                      ),
                      fillColor: Color(0xFFF5DCD5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 12.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "No. Telepon",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType:
                        TextInputType.number, // Ensure only numeric input
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      filled: true,
                      hintText: "Masukkan Nomor Telepon",
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.call),
                      ),
                      fillColor: Color(0xFFF5DCD5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        filled: true,
                        hintText: "Masukkan Password",
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.key),
                        ),
                        fillColor: Color(0xFFF5DCD5),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _signup,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(37),
                                border: Border.all(
                                  color: Color(0xFFF5DCD5),
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Color(0xFFC23F4F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()),
                            );
                          },
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC23F4F),
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FrontWidget()),
                        );
                      },
                      child: Text(
                        "cancel",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
