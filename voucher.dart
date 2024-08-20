import 'package:flutter/material.dart';

class VoucherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: [
        SizedBox(width: 25.0),
        Stack(
          children: [
            Container(
              height: 115,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFC23F4F),
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
                  const SizedBox(width: 5.0),
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
        const SizedBox(height: 15.0),
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
                          color: const Color(0xFFC23F4F),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        '*minimal pembelian 25kg',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(width: 5.0),
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
        const SizedBox(height: 15.0),
        Stack(children: [
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
                          color: const Color(0xFFC23F4F),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Bundling 1: bawang merah & bawang putih\nBundling 2: bawang putih & bawang bombay',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ]),
                ]),
          ),
        ]),
      ]),
    );
  }
}
