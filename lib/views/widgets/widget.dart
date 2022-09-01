
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logo/controllers/app_controller.dart';
import 'package:logo/controllers/auth_controller.dart';
import 'package:logo/views/pages/all_hotel_page.dart';
import 'package:logo/views/pages/first_page.dart';
import 'package:logo/views/pages/near_me.dart';

import '../constants/styles.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.weight})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.justify,
        style: GoogleFonts.rubik(
            textStyle:
                TextStyle(fontSize: size, color: color, fontWeight: weight)));
  }
}

class CustomWidget1 extends StatelessWidget {
  const CustomWidget1(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.weight})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.start,
        style: GoogleFonts.playfairDisplay(
            textStyle:
                TextStyle(fontSize: size, color: color, fontWeight: weight)));
  }
}

class FormWidget extends StatelessWidget {
  FormWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  var controller = Get.find<AuthController>();

  @override
  Widget build(
    BuildContext context,
  ) {
    TextEditingController tcontroller;

    switch (text) {
      case "Email":
        tcontroller = controller.email;
        break;
      case "Username":
        tcontroller = controller.userName;
        break;
      case "Phone":
        tcontroller = controller.phone;
        break;

      default:
        tcontroller = controller.email;
        break;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          controller: tcontroller,
          style: GoogleFonts.poppins(
              color: blue, fontWeight: FontWeight.w400, fontSize: 15),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            hintText: text,
            labelText: text,
            labelStyle: TextStyle(color: blue),
            fillColor: Colors.white,
            prefixIconColor: blue,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            hintStyle: TextStyle(color: blue, fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: blue),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: blue),
              borderRadius: BorderRadius.circular(15),
            ),
          )),
    );
  }
}
class navBar extends StatefulWidget {
 navBar(context,this.index);
var index;
  @override
  _navBarState createState() => _navBarState(index: index);
}

class _navBarState extends State<navBar> {
  _navBarState({required this.index});
  var index=0;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Container(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>FirstPage()));
                },
                icon: Icon(
                  Icons.explore,
                  color: index==0?blue:Color.fromARGB(70, 14, 83, 140),
                  size: 35,
                )),
            IconButton(
                onPressed: () {

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>nearMePage()));
                },
                icon:  Icon(Icons.near_me,
                    size: 35, color:index==1?blue:Color.fromARGB(70, 14, 83, 140))),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AllHotelPage()));
                },
                icon:Icon(Icons.hotel,
                    size: 35, color: index==2?blue:Color.fromARGB(70, 14, 83, 140))),
            IconButton(
                onPressed: () {
                  // setState(() {
                  //   pageIndex = 1;
                  // });
                },
                icon:
                // pageIndex == 1
                // ? const Icon(
                //     Icons.credit_card,
                //     color: Colors.white,
                //     size: 35,
                //   )
                // :
                Icon(Icons.settings,
                    size: 35, color:index==3?blue:Color.fromARGB(70, 14, 83, 140))),
            IconButton(
                onPressed: () {
                  // setState(() {
                  //   pageIndex = 3;
                  // });
                },
                icon: Icon(
                  Icons.question_mark_sharp,
                  size: 35,
                  color:index==4?blue:Color.fromARGB(70, 14, 83, 140),
                )),
          ],
        ),
      ),
    );
  }
}


Widget searchBar(TextEditingController tcontroller) {
  var c = Get.find<AppController>();

  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 0, 0, 0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          width: 300,
          child: TextFormField(
            controller: tcontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: blue),
                hintText: 'Search your event or place',
                contentPadding: EdgeInsets.all(5),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white, width: 3.0))),
          ),
        ),
      ),
      SizedBox(width: 5),
      Container(
          width: 50,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 0, 0, 0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: IconButton(
            icon: Icon(
              Icons.filter_alt_rounded,
              color: blue,
            ),
            onPressed: () {
            c.placessearch.value=c.places.where((p0) => p0.name.toLowerCase().contains(tcontroller.text.toLowerCase())).toList();
            },
          )),
    ],
  );
}
