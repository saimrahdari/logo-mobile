import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:logo/controllers/app_controller.dart';
import 'package:logo/views/constants/styles.dart';
import 'package:logo/views/pages/details.dart';
import 'package:logo/views/widgets/widget.dart';

class HotelsPage extends StatefulWidget {
  const HotelsPage({Key? key}) : super(key: key);

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  List<String> cName = [
    "Grand Hotel,London",
    "International Hotel,London",
    "Grand Hotel,London"
  ];
  List<String> Prod = ["3.6", "4.5", "3.5"];
  List<String> img = [
    'assets/first.png',
    'assets/first.png',
    "assets/first.png"
  ];
  @override
  Widget build(BuildContext context) {
    var c = Get.find<AppController>();

    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: navBar(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomWidget(
                      text: ("Hi Beyond,"),
                      size: 15,
                      color: Color.fromARGB(122, 14, 83, 140),
                      weight: FontWeight.w500),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.account_circle,
                        color: blue,
                        size: 35,
                      )),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              CustomWidget1(
                  text: "Explore everything near you!",
                  size: 28,
                  color: blue,
                  weight: FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              searchBar(c.search),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    child: CustomWidget(
                        text: "Near me",
                        size: 20,
                        color: blue,
                        weight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CustomWidget(
                              text: "Top",
                              size: 10,
                              color: Color.fromARGB(142, 0, 0, 0),
                              weight: FontWeight.normal),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomWidget(
                                  text: "Hotels",
                                  size: 10,
                                  color: blue,
                                  weight: FontWeight.normal),
                              Icon(
                                Icons.fiber_manual_record_rounded,
                                size: 8,
                                color: blue,
                              ),
                            ],
                          ),
                          CustomWidget(
                              text: "Event",
                              size: 10,
                              color: Color.fromARGB(142, 0, 0, 0),
                              weight: FontWeight.normal),
                          CustomWidget(
                              text: "Restaurants",
                              size: 10,
                              color: Color.fromARGB(142, 0, 0, 0),
                              weight: FontWeight.normal),
                          CustomWidget(
                              text: "Dining",
                              size: 10,
                              color: Color.fromARGB(142, 0, 0, 0),
                              weight: FontWeight.normal),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 400,
                child: ListView.builder(
                    itemCount: c.places.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                    id: '',
                                        description: "",
                                        email: '',
                                        image: '',
                                        name: '',
                                        phone: '',
                                        ratings: 2.0,
                                        type: '',
                                        location: LocationData.fromMap({}),
                                      )));
                        },
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                image: DecorationImage(
                                  image: AssetImage(img[index]),
                                  fit: BoxFit.cover,
                                )),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 18.0, left: 10, right: 10),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomWidget(
                                          text: cName[index],
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
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
                                                text: Prod[index],
                                                size: 12,
                                                color: blue,
                                                weight: FontWeight.w500),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.keyboard_double_arrow_up,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
