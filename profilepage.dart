import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panenbawang/loginpage.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  File? _image;

  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
      name = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      phoneNumber = prefs.getString('phoneNumber') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(path.basename(imageFile.path));
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  void _changePhoto(BuildContext context) async {
    var status = await [
      Permission.photos,
      Permission.camera,
      Permission.storage,
    ].request();

    if (status[Permission.photos]!.isGranted &&
        status[Permission.camera]!.isGranted) {
      _openImageSourceSelection(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permission denied'),
      ));
    }
  }

  void _openImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _openGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _openCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _openCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(labelText: 'Nama'),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: email,
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: phoneNumber,
                  decoration: InputDecoration(labelText: 'No. Telepon'),
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: address,
                  decoration: InputDecoration(labelText: 'Alamat'),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _saveProfileChanges();
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveProfileChanges() async {
    try {
      String imageUrl = '';
      if (_image != null) {
        imageUrl = await _uploadImageToFirebase(_image!);
      }

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'profileImageUrl': imageUrl,
      });

      // Save user data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', name);
      await prefs.setString('email', email);
      await prefs.setString('phoneNumber', phoneNumber);
      await prefs.setString('address', address);

      setState(() {
        // Perbarui state lokal
      });
    } catch (error) {
      print('Error saving profile changes: $error');
    }
  }

  void _logout(BuildContext context) async {
    // Clear SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogInPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          _changePhoto(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // User information
            UserInfoCard(
              name: name,
              email: email,
              phoneNumber: phoneNumber,
              address: address,
            ),
            SizedBox(height: 20),
            // Tombol log out
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editProfile(context);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  const UserInfoCard({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $name', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Email: $email', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('No. Telepon: $phoneNumber', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Alamat: $address', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
