import 'package:flutter/material.dart';
import 'package:panenbawang/homepage.dart';

class BundlingPage extends StatelessWidget {
  const BundlingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bundling Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _buildContainer(context, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context, int index) {
    List<Map<String, dynamic>> products = [
      {
        'imageAsset': 'assets/images/mp.png',
        'title': 'Bawang Merah-Putih',
        'price': 'Rp 61.000',
        'description': 'Produk Bundling (*2kg)',
      },
      {
        'imageAsset': 'assets/images/bp.png',
        'title': 'Bawang Putih-Bombay',
        'price': 'Rp 74.000',
        'description': 'Produk Bundling (*2kg)',
      },
    ];

    Map<String, dynamic> product = products[index];

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    product['imageAsset'],
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Text(
                product['title'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2),
              Text(
                product['description'],
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['price'],
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFFC23F4F),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
