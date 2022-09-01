import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logo/views/pages/first_page.dart';
import 'package:logo/views/pages/menu_page.dart';
import 'package:logo/views/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () async => {
              Navigator.pop(context),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const FirstPage()))
            });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child:
          // backgroundColor: Colors.black,
          Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/Starting White.png"),
                fit: BoxFit.cover,
              )),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 80.0, left: 20, right: 20, bottom: 20),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Lets Start New Adventure',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 40,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Center(
                                  child: CustomWidget(
                                      text: "Terms & Conditions",
                                      size: 10,
                                      color: Color.fromARGB(158, 255, 255, 255),
                                      weight: FontWeight.normal),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'go',
          style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
              color: Color(0xffFF593C)),
          children: const [
            TextSpan(
              text: 'with',
              style: TextStyle(color: Colors.black, fontSize: 45),
            ),
            TextSpan(
              text: 'me',
              style: TextStyle(color: Color(0xffFF593C), fontSize: 45),
            ),
          ]),
    );
  }
}
