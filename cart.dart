import 'package:flutter/material.dart';
import 'package:panenbawang/formbbe.dart';
import 'package:panenbawang/formbbg.dart';
import 'package:panenbawang/formbbp.dart';
import 'package:panenbawang/formbme.dart';
import 'package:panenbawang/formbmg.dart';
import 'package:panenbawang/formbmp.dart';
import 'package:panenbawang/formbpe.dart';
import 'package:panenbawang/formbpg.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'name': 'Bawang Merah Ecer', 'price': 'Rp 35.000'},
    {'name': 'Bawang Putih Ecer', 'price': 'Rp 28.000'},
    {'name': 'Bawang Bombay Ecer', 'price': 'Rp 38.000'},
    {'name': 'Bawang Merah Grosir', 'price': 'Rp 31.000'},
    {'name': 'Bawang Putih Grosir', 'price': 'Rp 24.000'},
    {'name': 'Bawang Bombay Grosir', 'price': 'Rp 33.000'},
    {'name': 'Bawang Merah-Putih', 'price': 'Rp 61.000'},
    {'name': 'Bawang Bombay-Putih', 'price': 'Rp 74.000'},
  ];

  void _navigateToForm(BuildContext context, String productName) {
    if (productName == 'Bawang Merah Ecer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbmePage()),
      );
    } else if (productName == 'Bawang Putih Ecer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbpePage()),
      );
    } else if (productName == 'Bawang Bombay Ecer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbbePage()),
      );
    } else if (productName == 'Bawang Merah Grosir') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbmgPage()),
      );
    } else if (productName == 'Bawang Putih Grosir') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbpgPage()),
      );
    } else if (productName == 'Bawang Bombay Grosir') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbbgPage()),
      );
    } else if (productName == 'Bawang Merah-Putih') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbmpPage()),
      );
    } else if (productName == 'Bawang Bombay-Putih') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormbbpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _navigateToForm(context, products[index]['name']!);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5DCD5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index]['name']!,
                              style: TextStyle(
                                color: Color(0xFFC23F4F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              products[index]['price']!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.shopping_cart),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
