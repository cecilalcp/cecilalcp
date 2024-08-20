import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panenbawang/admin.dart';
import 'package:panenbawang/frontwidget.dart';
import 'package:panenbawang/homepage.dart';
import 'package:panenbawang/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  bool isCheckedRememberMe = false;
  bool isLoading = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Silahkan masukkan username dan password.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Check if the user is admin
    if (username == 'admin' && password == 'adminpawang') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboard(),
        ),
      );
      return;
    }

    final signUpUrl = Uri.parse(
        'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/user.json');

    try {
      final response = await http.get(signUpUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);
        if (responseData != null) {
          bool userFound = false;
          responseData.forEach((key, value) {
            if (value['username'] == username &&
                value['password'] == password) {
              userFound = true;
            }
          });

          if (userFound) {
            final loginUrl = Uri.parse(
                'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/login.json');

            final loginResponse = await http.post(
              loginUrl,
              body: json.encode({
                'username': username,
                'password': password,
              }),
            );

            if (loginResponse.statusCode == 200) {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
              prefs.setString('username', username);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            } else {
              _showErrorDialog('Gagal Login, silahkan coba lagi.');
            }
          } else {
            _showErrorDialog(
                'Username atau password salah. Silahkan coba lagi.');
          }
        } else {
          _showErrorDialog('Respon gagal diproses');
        }
      } else {
        _showErrorDialog(
            'Data tidak ditemukan. Status code: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog('Terjadi error. Silahkan coba lagi.');
      print("Error: $error");
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
                SizedBox(height: 15.0),
                Text(
                  "LogIn To Your Account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 50.0),
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
                SizedBox(height: 20.0),
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
                            onPressed: () {
                              _login();
                            },
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
                                "LogIn",
                                style: TextStyle(
                                  color: Color(0xFFC23F4F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 15.0),
                    Text(
                      'Lupa Password?',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 15.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
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
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFC23F4F),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.0),
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
