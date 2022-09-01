import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logo/controllers/auth_controller.dart';
import 'package:logo/logins/login.dart';
import 'package:logo/logins/signup.dart';
import 'package:logo/views/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/styles.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child:
          // backgroundColor: Colors.black,
          Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/Login-Signup White.png"),
                fit: BoxFit.cover,
              )),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 20, right: 20, bottom: 30),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Visit new places, events & hotels.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: MaterialButton(
                                height: 53,
                                minWidth: MediaQuery.of(context).size.width,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(35)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()));
                                },
                                child: CustomWidget(
                                    text: "Login",
                                    size: 14,
                                    color: Colors.white,
                                    weight: FontWeight.w500),
                                color: Color(0xff0E538C),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: MaterialButton(
                                height: 53,
                                minWidth: MediaQuery.of(context).size.width,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(35)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignupPage()));
                                },
                                child: CustomWidget(
                                    text: "Sign Up",
                                    size: 14,
                                    color: blue,
                                    weight: FontWeight.w500),
                                color: Color.fromARGB(220, 255, 255, 255),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))),
    );
  }
}
