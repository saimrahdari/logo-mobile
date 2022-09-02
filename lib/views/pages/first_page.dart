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

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var Currentindex = 0;
  PageController pageController = new PageController();
  List<String> cName = [
    "Grand Hotel,London",
    "Sawat,Pakistan",
    "Park Hayyat,Maldives",
    "Grand Hotel,London",
    "Grand Hotel,London",
    "Grand Hotel,London"
  ];
  List<String> Prod = ["3.6", "4.5", "3.5", "3.5", "3.5", "3.5"];
  List<String> img = [
    'assets/first.png',
    'assets/Sawat.png',
    'assets/Bali.png',
    "assets/Rectangle 33.png",
    "assets/Rectangle 34.png",
    "assets/Rectangle 32.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.find<AppController>();
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
        bottomNavigationBar: navBar(context, 0),
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
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get()
                            .asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        personal_profile_view()));
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(0, 3),
                                            blurRadius: 6,
                                            spreadRadius: 0)
                                      ],
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${snapshot.data?['image']}'),
                                          fit: BoxFit.cover),
                                      color: Colors.white)),
                            );
                          } else {
                            return IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          personal_profile_view()));
                                },
                                icon: Icon(
                                  Icons.account_circle,
                                  color: blue,
                                  size: 35,
                                ));
                          }
                        }),
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
                searchBar(c.search),
                SizedBox(
                  height: 10,
                ),
                CustomWidget(
                    text: "Categories",
                    size: 20,
                    color: blue,
                    weight: FontWeight.w500),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(children: [
                      GestureDetector(
                        child: card("Hotel", "assets/hotels.png"),
                        onTap: () {
                          setState(() {
                            Currentindex = 0;
                            pageController.jumpTo(0);
                          });
                          c.filter("hotel");
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        child: card("Resturaunts", "assets/Chair.png"),
                        onTap: () {
                          setState(() {
                            Currentindex = 3;
                            pageController.jumpTo(3);
                          });
                          c.filter("resturant");
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        child: card("Dining", "assets/Cutlery.png"),
                        onTap: () {
                          setState(() {
                            Currentindex = 4;
                            pageController.jumpTo(4);
                          });
                          c.filter("dining");
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        child: card("Location", "assets/Location.png"),
                        onTap: () {
                          setState(() {
                            Currentindex = 2;
                            pageController.jumpTo(2);
                          });
                          c.filter("location");
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        child: card("Events", "assets/Autumn.png"),
                        onTap: () {
                          setState(() {
                            Currentindex = 1;
                            pageController.jumpTo(1);
                          });
                          c.filter("event");
                        },
                      ),
                    ])),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      child: CustomWidget(
                          text: "Popular",
                          size: 20,
                          color: blue,
                          weight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget(
                                text: "Top Hotels",
                                size: 10,
                                color: blue,
                                weight: FontWeight.normal),
                            Visibility(
                              visible: Currentindex == 0,
                              child: Icon(
                                Icons.fiber_manual_record_rounded,
                                size: 8,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget(
                                text: "Event",
                                size: 10,
                                color: blue,
                                weight: FontWeight.normal),
                            Visibility(
                              visible: Currentindex == 1,
                              child: Icon(
                                Icons.fiber_manual_record_rounded,
                                size: 8,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget(
                                text: "Locations",
                                size: 10,
                                color: blue,
                                weight: FontWeight.normal),
                            Visibility(
                              visible: Currentindex == 2,
                              child: Icon(
                                Icons.fiber_manual_record_rounded,
                                size: 8,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget(
                                text: "Resturants",
                                size: 10,
                                color: blue,
                                weight: FontWeight.normal),
                            Visibility(
                              visible: Currentindex == 3,
                              child: Icon(
                                Icons.fiber_manual_record_rounded,
                                size: 8,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomWidget(
                                text: "Dining",
                                size: 10,
                                color: blue,
                                weight: FontWeight.normal),
                            Visibility(
                              visible: Currentindex == 4,
                              child: Icon(
                                Icons.fiber_manual_record_rounded,
                                size: 8,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() => c.placessearch.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            c.places.clear();
                            setState(() {
                              Currentindex = index;
                              if (index == 0) {
                                c.filter("hotel");
                              } else if (index == 3) {
                                c.filter("resturant");
                              } else if (index == 4) {
                                c.filter("dining");
                              } else if (index == 2) {
                                c.filter("location");
                              } else if (index == 1) {
                                c.filter("event");
                              }
                            });
                          },
                          children: [
                            SizedBox(
                              //height: 260,
                              child: Obx(
                                () => SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.0,
                                    child: StaggeredGridView.countBuilder(
                                        // physics: ClampingScrollPhysics(),
                                        //shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        itemCount: c.places.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(
                                                  c..places.length.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details(
                                                            id: c.places[index]
                                                                .id,
                                                            description: c
                                                                .places[index]
                                                                .description,
                                                            email: c
                                                                .places[index]
                                                                .email,
                                                            image: c
                                                                .places[index]
                                                                .image,
                                                            name: c
                                                                .places[index]
                                                                .name,
                                                            phone: c
                                                                .places[index]
                                                                .phone,
                                                            ratings: c
                                                                .places[index]
                                                                .ratings,
                                                            type: c
                                                                .places[index]
                                                                .type,
                                                            location: c
                                                                .places[index]
                                                                .location,
                                                          )));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    image: DecorationImage(
                                                      // image: AssetImage(img[index]),
                                                      image: NetworkImage(c
                                                          .places[index].image),
                                                      fit: BoxFit.fill,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 18.0,
                                                      left: 12,
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomWidget(
                                                              text: c
                                                                  .places[index]
                                                                  .name,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                              weight: FontWeight
                                                                  .w500),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 40,
                                                            height: 20,
                                                            // color: Colors.white,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xffFCD635),
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                CustomWidget(
                                                                    text: c
                                                                        .places[
                                                                            index]
                                                                        .ratings
                                                                        .toString(),
                                                                    size: 12,
                                                                    color: blue,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_double_arrow_up,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        staggeredTileBuilder: (index) {
                                          return StaggeredTile.count(
                                              1, index.isEven ? 1.05 : 1.5);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              //height: 260,
                              child: Obx(
                                () => SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.0,
                                    child: StaggeredGridView.countBuilder(
                                        // physics: ClampingScrollPhysics(),
                                        //shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        itemCount: c.places.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(
                                                  c..places.length.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details(
                                                            id: c.places[index]
                                                                .id,
                                                            description: c
                                                                .places[index]
                                                                .description,
                                                            email: c
                                                                .places[index]
                                                                .email,
                                                            image: c
                                                                .places[index]
                                                                .image,
                                                            name: c
                                                                .places[index]
                                                                .name,
                                                            phone: c
                                                                .places[index]
                                                                .phone,
                                                            ratings: c
                                                                .places[index]
                                                                .ratings,
                                                            type: c
                                                                .places[index]
                                                                .type,
                                                            location: c
                                                                .places[index]
                                                                .location,
                                                          )));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    image: DecorationImage(
                                                      // image: AssetImage(img[index]),
                                                      image: NetworkImage(c
                                                          .places[index].image),
                                                      fit: BoxFit.fill,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 18.0,
                                                      left: 12,
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomWidget(
                                                              text: c
                                                                  .places[index]
                                                                  .name,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                              weight: FontWeight
                                                                  .w500),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 40,
                                                            height: 20,
                                                            // color: Colors.white,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xffFCD635),
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                CustomWidget(
                                                                    text: c
                                                                        .places[
                                                                            index]
                                                                        .ratings
                                                                        .toString(),
                                                                    size: 12,
                                                                    color: blue,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_double_arrow_up,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        staggeredTileBuilder: (index) {
                                          return StaggeredTile.count(
                                              1, index.isEven ? 1.05 : 1.5);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              //height: 260,
                              child: Obx(
                                () => SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.0,
                                    child: StaggeredGridView.countBuilder(
                                        // physics: ClampingScrollPhysics(),
                                        //shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        itemCount: c.places.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(
                                                  c..places.length.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details(
                                                            id: c.places[index]
                                                                .id,
                                                            description: c
                                                                .places[index]
                                                                .description,
                                                            email: c
                                                                .places[index]
                                                                .email,
                                                            image: c
                                                                .places[index]
                                                                .image,
                                                            name: c
                                                                .places[index]
                                                                .name,
                                                            phone: c
                                                                .places[index]
                                                                .phone,
                                                            ratings: c
                                                                .places[index]
                                                                .ratings,
                                                            type: c
                                                                .places[index]
                                                                .type,
                                                            location: c
                                                                .places[index]
                                                                .location,
                                                          )));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    image: DecorationImage(
                                                      // image: AssetImage(img[index]),
                                                      image: NetworkImage(c
                                                          .places[index].image),
                                                      fit: BoxFit.fill,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 18.0,
                                                      left: 12,
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomWidget(
                                                              text: c
                                                                  .places[index]
                                                                  .name,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                              weight: FontWeight
                                                                  .w500),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 40,
                                                            height: 20,
                                                            // color: Colors.white,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xffFCD635),
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                CustomWidget(
                                                                    text: c
                                                                        .places[
                                                                            index]
                                                                        .ratings
                                                                        .toString(),
                                                                    size: 12,
                                                                    color: blue,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_double_arrow_up,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        staggeredTileBuilder: (index) {
                                          return StaggeredTile.count(
                                              1, index.isEven ? 1.05 : 1.5);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              //height: 260,
                              child: Obx(
                                () => SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.0,
                                    child: StaggeredGridView.countBuilder(
                                        // physics: ClampingScrollPhysics(),
                                        //shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        itemCount: c.places.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(
                                                  c..places.length.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details(
                                                            id: c.places[index]
                                                                .id,
                                                            description: c
                                                                .places[index]
                                                                .description,
                                                            email: c
                                                                .places[index]
                                                                .email,
                                                            image: c
                                                                .places[index]
                                                                .image,
                                                            name: c
                                                                .places[index]
                                                                .name,
                                                            phone: c
                                                                .places[index]
                                                                .phone,
                                                            ratings: c
                                                                .places[index]
                                                                .ratings,
                                                            type: c
                                                                .places[index]
                                                                .type,
                                                            location: c
                                                                .places[index]
                                                                .location,
                                                          )));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    image: DecorationImage(
                                                      // image: AssetImage(img[index]),
                                                      image: NetworkImage(c
                                                          .places[index].image),
                                                      fit: BoxFit.fill,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 18.0,
                                                      left: 12,
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomWidget(
                                                              text: c
                                                                  .places[index]
                                                                  .name,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                              weight: FontWeight
                                                                  .w500),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 40,
                                                            height: 20,
                                                            // color: Colors.white,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xffFCD635),
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                CustomWidget(
                                                                    text: c
                                                                        .places[
                                                                            index]
                                                                        .ratings
                                                                        .toString(),
                                                                    size: 12,
                                                                    color: blue,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_double_arrow_up,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        staggeredTileBuilder: (index) {
                                          return StaggeredTile.count(
                                              1, index.isEven ? 1.05 : 1.5);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              //height: 260,
                              child: Obx(
                                () => SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.0,
                                    child: StaggeredGridView.countBuilder(
                                        // physics: ClampingScrollPhysics(),
                                        //shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        itemCount: c.places.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(
                                                  c..places.length.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details(
                                                            id: c.places[index]
                                                                .id,
                                                            description: c
                                                                .places[index]
                                                                .description,
                                                            email: c
                                                                .places[index]
                                                                .email,
                                                            image: c
                                                                .places[index]
                                                                .image,
                                                            name: c
                                                                .places[index]
                                                                .name,
                                                            phone: c
                                                                .places[index]
                                                                .phone,
                                                            ratings: c
                                                                .places[index]
                                                                .ratings,
                                                            type: c
                                                                .places[index]
                                                                .type,
                                                            location: c
                                                                .places[index]
                                                                .location,
                                                          )));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    image: DecorationImage(
                                                      // image: AssetImage(img[index]),
                                                      image: NetworkImage(c
                                                          .places[index].image),
                                                      fit: BoxFit.fill,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 18.0,
                                                      left: 12,
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomWidget(
                                                              text: c
                                                                  .places[index]
                                                                  .name,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                              weight: FontWeight
                                                                  .w500),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 40,
                                                            height: 20,
                                                            // color: Colors.white,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color(
                                                                      0xffFCD635),
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                CustomWidget(
                                                                    text: c
                                                                        .places[
                                                                            index]
                                                                        .ratings
                                                                        .toString(),
                                                                    size: 12,
                                                                    color: blue,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_double_arrow_up,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        staggeredTileBuilder: (index) {
                                          return StaggeredTile.count(
                                              1, index.isEven ? 1.05 : 1.5);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 2.0,
                        child: StaggeredGridView.countBuilder(
                            // physics: ClampingScrollPhysics(),
                            //shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                            itemCount: c.placessearch.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(c..placessearch.length.toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                                id: c.placessearch[index].id,
                                                description: c
                                                    .placessearch[index]
                                                    .description,
                                                email:
                                                    c.placessearch[index].email,
                                                image:
                                                    c.placessearch[index].image,
                                                name:
                                                    c.placessearch[index].name,
                                                phone:
                                                    c.placessearch[index].phone,
                                                ratings: c.placessearch[index]
                                                    .ratings,
                                                type:
                                                    c.placessearch[index].type,
                                                location: c.placessearch[index]
                                                    .location,
                                              )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        image: DecorationImage(
                                          // image: AssetImage(img[index]),
                                          image: NetworkImage(
                                              c.placessearch[index].image),
                                          fit: BoxFit.fill,
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 18.0, left: 12, right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomWidget(
                                                  text: c
                                                      .placessearch[index].name,
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
                                                                20))),
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
                                                        text: c
                                                            .placessearch[index]
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
                                          Icon(
                                            Icons.keyboard_double_arrow_up,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                            staggeredTileBuilder: (index) {
                              return StaggeredTile.count(
                                  1, index.isEven ? 1.05 : 1.5);
                            }),
                      )),
                // CustomWidget1(),
                Container(
                  color: Colors.red,
                )
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
