import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/CustomTextFields.dart';

class edit_profile_view extends StatefulWidget {
  const edit_profile_view({Key, key}) : super(key: key);

  @override
  _edit_profile_viewState createState() => _edit_profile_viewState();
}

class _edit_profile_viewState extends State<edit_profile_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff4f8),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 41,
                          height: 41,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x76fd7bac),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                    spreadRadius: 0)
                              ],
                              color: Colors.white),
                          child: Icon(
                            Icons.clear,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Text("   Bilgilerinizi Düzenleyin",
                          style: const TextStyle(
                              color: const Color(0xff232a2c),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Avenir",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Ad Soyad",
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color(0xff939393),
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          prefixIcon: Icon(Icons.person_outline,color: Colors.grey.shade400,),
                        ),
                        Text(
                          'Telefon',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          prefixIcon: Icon(CupertinoIcons.phone,color: Colors.grey.shade400,),
                        ),
                        Text(
                          'Eposta',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          prefixIcon: Icon(Icons.email_outlined,color: Colors.grey.shade400,),
                        ),
                        Text(
                          'Parola',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          prefixIcon: Icon(FontAwesomeIcons.key,color: Colors.grey.shade400,size: 15,),
                          leadinIcon: Icon(FontAwesomeIcons.eye,color:Theme.of(context).primaryColor,size: 20,),

                        ),
                        Text(
                          'Parola (Tekrar)',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          prefixIcon: Icon(FontAwesomeIcons.key,color: Colors.grey.shade400,size: 15,),
                          leadinIcon: Icon(FontAwesomeIcons.eye,color:Theme.of(context).primaryColor,size: 20,),

                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xfffd7bac),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text('Kaydet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w900,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.3,
            width: 120,
            height: 120,
            child: Container(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 10),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                                spreadRadius: 0)
                          ],
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Mask Group 44.png'),
                              fit: BoxFit.contain),
                          color: Colors.white)),
                  Positioned(
                      right: 0,
                      child: Icon(
                        Icons.add_circle_sharp,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
