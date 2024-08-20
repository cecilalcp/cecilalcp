import 'package:flutter/material.dart';
import 'package:panenbawang/cart.dart';
import 'package:panenbawang/categorieswidget.dart';
import 'package:panenbawang/chat.dart';
import 'package:panenbawang/order.dart';
import 'package:panenbawang/product.dart';
import 'package:panenbawang/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5DCD5),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: 150,
              ),
            ),
            SizedBox(width: 120.0),
            Icon(Icons.notifications),
            SizedBox(width: 5.0),
            Text(
              '|',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Text(
                'username',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5DCD5),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Tambahkan ini
              children: [
                SizedBox(height: 5.0),
                TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    filled: true,
                    hintText: "cari bawang",
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                    fillColor: Color.fromARGB(255, 255, 252, 252),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(37),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    child: Text(
                      "PRODUK LOKAL",
                      style: TextStyle(
                          color: Color(0xFFC23F4F),
                          fontWeight: FontWeight.w700,
                          fontSize: 25),
                    ),
                  ),
                  Icon(
                    Icons.local_offer,
                    color: Colors.pinkAccent,
                    size: 30.0,
                  )
                ]),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      height: 115,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFC23F4F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              'Berasal dari 20+\nlahan petani Probolinggo,\nBrebes,dan Nganjuk\ndengan harga eceran\n&  grosir terbaik!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.asset(
                                  'assets/images/bombay1.png',
                                  height: 150,
                                  width: 115,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(),
                  child: Text(
                    "Kategori",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CategoriesWidget(),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(),
                  child: Text(
                    "Harga lebih murah",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 25.0),
                Stack(
                  children: [
                    Container(
                      height: 115,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35, left: 15),
                              child: Text(
                                'Diskon lebih dari 10%',
                                style: TextStyle(
                                  color: Color(0xFFC23F4F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                '*minimal pembelian 25kg',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            width: 5.0,
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.asset(
                                  'assets/images/grosir.png',
                                  height: 150,
                                  width: 115,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Stack(
                  children: [
                    Container(
                      height: 115,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            child: Image.asset(
                              'assets/images/bundling.png',
                              height: 150,
                              width: 115,
                            ),
                          ),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                              ),
                              child: Text(
                                'Diskon lebih dari 2%',
                                style: TextStyle(
                                  color: Color(0xFFC23F4F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                'Bundling 1: bawang merah & bawang putih\nBundling 2: bawang putih & bawang bombay',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            width: 5.0,
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    "KATALOG",
                    style: TextStyle(
                      color: Color(0xFFC23F4F),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ProductPage(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.home),
                  Text('Beranda'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.shopping_cart),
                  Text('Keranjang'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.note_alt),
                  Text('Pesanan'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.chat),
                  Text('Chat'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
