
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logo/constants/firebase.dart';
import 'package:logo/views/constants/styles.dart';

import '../widgets/CustomTextFields.dart';
import 'edit_profile_view.dart';

class personal_profile_view extends StatefulWidget {
  const personal_profile_view({Key,key}) : super(key: key);

  @override
  _personal_profile_viewState createState() => _personal_profile_viewState();
}

class _personal_profile_viewState extends State<personal_profile_view> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue.withOpacity(0.5),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
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
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        Text(
                          "User Name",
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color(0xff939393),
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person_outline,color: Colors.grey.shade400,),
                              Text(
                                '  ${FirebaseAuth.instance.currentUser!.displayName}',
                                style: TextStyle(
                                  color: Color(0xff939393),
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Phone',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.phone,color: Colors.grey.shade400,),
                              Text(
                                '  ${FirebaseAuth.instance.currentUser!.phoneNumber}',
                                style: TextStyle(
                                  color: Color(0xff939393),
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.mail,color: Colors.grey.shade400,),
                              Text(
                                '  ${FirebaseAuth.instance.currentUser!.email}',
                                style: TextStyle(
                                  color: Color(0xff939393),
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///////
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Get.to(edit_profile_view());
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color:white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text('Edit Profile',
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 16,
                                      fontFamily: 'Avenir',
                                      fontWeight: FontWeight.w900,
                                    ))),
                          ),
                        ),
                        SizedBox(height:MediaQuery.of(context).size.height*0.12,),
                        InkWell(
                          onTap: (){
                            auth.signOut();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color:blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text('Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Avenir',
                                      fontWeight: FontWeight.w900,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().asStream(),
                      builder: (context, snapshot) {
                        return Container(
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
                                    NetworkImage('${snapshot.data?['image']}'),
                                    fit: BoxFit.cover),
                                color: Colors.white));
                      }
                    ),
                    Positioned(
                        right: 0,
                        child: InkWell(
                          onTap: ()async{
                            FilePickerResult? image = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'pdf', 'doc'],
                            );
                            if(image!=null){
                            File file = File(image.files.single.path!);
                             if(image!=null)
                               FirebaseStorage.instance.ref('profileImages').putFile(file).then((p0) =>
                               {
                                 p0.ref.getDownloadURL().then((value) { FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
                                     {
                                       'image':value
                                     });
                               })
                               });
                            }

                          },
                          child: Icon(
                            Icons.add_circle_sharp,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
