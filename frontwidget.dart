import 'package:flutter/material.dart';
import 'package:panenbawang/loginpage.dart';

class FrontWidget extends StatefulWidget {
  FrontWidget({super.key});

  @override
  State<FrontWidget> createState() => _FrontWidget();
}

class _FrontWidget extends State<FrontWidget> {
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
            child: Column(children: [
              SizedBox(height: 10.0),
              Center(child: Image.asset('assets/images/logo.png')),
              Center(
                  child: Image.asset(
                'assets/images/front.png',
                height: 350,
                width: 300,
              )),
              SizedBox(height: 50.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInPage()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(37),
                    border: Border.all(
                      color: Color(0xFFC23F4F),
                      width: 2,
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "START",
                          style: TextStyle(
                            color: Color(0xFFC23F4F),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Icon(Icons.arrow_forward_outlined)
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
