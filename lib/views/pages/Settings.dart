import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logo/views/pages/PrivacyPolicyPage.dart';
import 'package:logo/views/pages/TermsAndConditionsPage.dart';
import 'package:logo/views/pages/personal_profile_view.dart';

import '../../constants/firebase.dart';
import '../constants/styles.dart';
import '../widgets/widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: navBar(context, 3),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomWidget(
                          text: ("Hi ${auth.currentUser!.displayName},"),
                          size: 15,
                          color: Color.fromARGB(122, 14, 83, 140),
                          weight: FontWeight.w500),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().asStream(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>personal_profile_view()));
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0x29000000),
                                            offset: Offset(0, 3),
                                            blurRadius: 6,
                                            spreadRadius: 0)
                                      ],
                                      image: DecorationImage(
                                          image:
                                          NetworkImage('${snapshot.data?['image']}'),
                                          fit: BoxFit.cover),
                                      color: Colors.white)),
                            );
                          }else{ return IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>personal_profile_view()));
                              },
                              icon: Icon(
                                Icons.account_circle,
                                color: blue,
                                size: 35,
                              ));}}
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                CustomWidget1(
                    text: "More options",
                    size: 28,
                    color: blue,
                    weight: FontWeight.w700),
               ////////
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    Get.to(PrivacyPolicyPage());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('Privacy Policy',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                ///////
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    Get.to(TermsAndConditionsPage());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('Terms & conditions',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
