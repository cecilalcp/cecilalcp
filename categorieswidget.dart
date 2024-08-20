import 'package:flutter/material.dart';
import 'package:panenbawang/bundling.dart';
import 'package:panenbawang/ecer.dart';
import 'package:panenbawang/grosir.dart';

class CategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 15.0),
          _buildCategory(
            context,
            'assets/images/grosir.png',
            'grosir',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GrosirPage()),
              );
            },
          ),
          SizedBox(width: 25.0),
          _buildCategory(
            context,
            'assets/images/ecer.png',
            'ecer',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EcerPage()),
              );
            },
          ),
          SizedBox(width: 25.0),
          _buildCategory(
            context,
            'assets/images/bundling.png',
            'bundling',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BundlingPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(
    BuildContext context,
    String imagePath,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFC23F4F),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    width: 75,
                    height: 75,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
