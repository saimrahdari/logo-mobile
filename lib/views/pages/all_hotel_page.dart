// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logo/constants/firebase.dart';
import 'package:logo/controllers/app_controller.dart';
import 'package:logo/controllers/auth_controller.dart';
import 'package:logo/views/pages/near_me.dart';
import 'package:logo/views/pages/personal_profile_view.dart';
import 'package:logo/views/widgets/widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../constants/styles.dart';
import 'details.dart';

class AllHotelPage extends StatefulWidget {
  const AllHotelPage({Key? key}) : super(key: key);

  @override
  State<AllHotelPage> createState() => _AllHotelPageState();
}

class _AllHotelPageState extends State<AllHotelPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var c = Get.find<AppController>();
    c.filter('hotel');
    
    
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.my_location_sharp,
                size: 25,
              ),
              onPressed: () {
                c.getLocation();
              },
            ),
          ),
        ),
        bottomNavigationBar: navBar(context,2),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
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
                    text: "Explore the beautiful world!",
                    size: 28,
                    color: blue,
                    weight: FontWeight.w700),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 80,
                  child: CustomWidget(
                      text: "Popular",
                      size: 20,
                      color: blue,
                      weight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.65,
                  child: SizedBox(
                    //height: 260,
                    child: Obx(
                          () => SingleChildScrollView(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.0,
                          child: ListView.builder(
                            // physics: ClampingScrollPhysics(),
                            //shrinkWrap: true,

                              itemCount: c.places.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(c.places.length.toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                              id: c.places[index].id,
                                              description:
                                              c.places[index].description,
                                              email: c.places[index].email,
                                              image: c.places[index].image,
                                              name: c.places[index].name,
                                              phone: c.places[index].phone,
                                              ratings:
                                              c.places[index].ratings,
                                              type: c.places[index].type,
                                              location:
                                              c.places[index].location,
                                            )));
                                  },
                                  child: Container(
                                    height: 150,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          image: DecorationImage(
                                            // image: AssetImage(img[index]),
                                            image: NetworkImage(
                                                c.places[index].image),
                                            fit: BoxFit.fill,
                                          )),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 18.0, left: 12, right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    CustomWidget(
                                                        text: c.places[index].name,
                                                        size: 13,
                                                        color: Colors.white,
                                                        weight: FontWeight.w500),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      height: 20,
                                                      // color: Colors.white,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Color(0xffFCD635),
                                                            size: 13,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          CustomWidget(
                                                              text: c.places[index]
                                                                  .ratings
                                                                  .toString(),
                                                              size: 12,
                                                              color: blue,
                                                              weight:
                                                              FontWeight.w500),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                              ],
                                            ),  Icon(
                                              Icons
                                                  .keyboard_double_arrow_up,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
                // CustomWidget1(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget card(String text, img) {
  return Column(
    children: [
      Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            height: 60,
            width: 70,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  img,
                ))),
      ),
      SizedBox(
        height: 5,
      ),
      CustomWidget(
          text: text,
          size: 10,
          color: Color.fromARGB(117, 0, 0, 0),
          weight: FontWeight.normal),
    ],
  );
}
