import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/CustomTextFields.dart';

class edit_profile_view extends StatefulWidget {
  const edit_profile_view({Key, key}) : super(key: key);

  @override
  _edit_profile_viewState createState() => _edit_profile_viewState();
}

class _edit_profile_viewState extends State<edit_profile_view> {
  var controller = Get.find<AuthController>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
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
                      Text("   Edit your profile",
                          style: const TextStyle(
                              color: Colors.white,
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
                          "Name",
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color(0xff939393),
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          controller: name,
                          prefixIcon: Icon(Icons.person_outline,color: Colors.grey.shade400,),
                        ),
                        Text(
                          'Phone number',
                          style: TextStyle(
                            color: Color(0xff939393),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomTextFields(obscureText: false,
                          controller: phone,
                          prefixIcon: Icon(CupertinoIcons.phone,color: Colors.grey.shade400,),
                        ),
                        ///////
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            controller.updateInfo(name.text, phone.text);
                            Get.snackbar('Info Updated', 'Your Name & phone number is updated.',colorText: Colors.white,backgroundColor: Colors.black26);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text('Update Info',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            resetPassword();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text('Reset Password',
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

  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser!.email!);
    Get.snackbar('Password reset link sent', 'A password reset link has been sent to your registered email address.',colorText: Colors.white,backgroundColor: Colors.black26);
  }
}
