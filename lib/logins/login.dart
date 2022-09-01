import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logo/controllers/auth_controller.dart';

import 'package:logo/views/constants/styles.dart';
import 'package:logo/logins/signup.dart';
import 'package:logo/views/pages/first_page.dart';
import 'package:logo/views/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController contactController = TextEditingController();

  var controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/Login-White.png"),
            fit: BoxFit.fill,
          )),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(68, 0, 0, 0),
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0,
                                          2.0), // shadow direction: bottom right
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: blue,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomWidget(
                          text: "Welcome Back!",
                          size: 24,
                          color: blue,
                          weight: FontWeight.w500),
                      SizedBox(
                        height: 10,
                      ),
                      CustomWidget(
                          text: "Login To Your Existing Account.",
                          size: 15,
                          color: blue,
                          weight: FontWeight.normal),
                      SizedBox(
                        height: 25,
                      ),
                      FormWidget(
                        text: "Email",
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                            controller: controller.password,
                            obscureText: true,
                            style: GoogleFonts.poppins(
                                color: blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              hintText: "Password",
                              labelText: "Password",
                              labelStyle: TextStyle(color: blue),
                              fillColor: Colors.white,
                              prefixIconColor: blue,
                              suffixIcon: Icon(
                                Icons.visibility_off,
                                color: blue,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              hintStyle: TextStyle(
                                  color: blue, fontWeight: FontWeight.w400),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15)),
                        onPressed: () {
                          controller.signIn();
                        },
                        child: const CustomWidget(
                            text: "Login",
                            size: 14,
                            color: Colors.white,
                            weight: FontWeight.w500),
                        color: blue,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomWidget(
                              text: "Don't have an account?",
                              size: 15,
                              color: Color.fromARGB(255, 143, 138, 138),
                              weight: FontWeight.normal),
                          SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            child: CustomWidget(
                              size: 15,
                              text: "Signup",
                              color: blue,
                              weight: FontWeight.normal,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignupPage()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
