import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:logo/views/constants/styles.dart';
import 'package:logo/views/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class Details extends StatefulWidget {
  String description = " ",
      id = '',
      name = " ",
      email = " ",
      phone = " ",
      image = " ",
      type = " ";
  double ratings = 0.0;
  LocationData location;

  Details(
      {Key? key,
      required this.description,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.type,
      required this.ratings,
      required this.location,
      required this.id})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
        image: AssetImage("assets/Details-white.png"),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        // bottomNavigationBar: navBar(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Icon(
                    Icons.arrow_back,
                    color: blue,
                  )),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.account_circle,
                    size: 35,
                  )),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidget(
                        text: widget.name,
                        size: 30,
                        color: Colors.white,
                        weight: FontWeight.w500),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          size: 20,
                          color: Color.fromARGB(155, 157, 166, 184),
                        ),
                        CustomWidget(
                            text: "Umm Sequin 3 - Dubai",
                            size: 10,
                            color: Color.fromARGB(155, 157, 166, 184),
                            weight: FontWeight.normal),
                      ],
                    )
                  ],
                ),
              ),
              height: height * 0.46,
              width: width,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(80)),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidget(
                            text: "Ratings",
                            size: 20,
                            color: blue,
                            weight: FontWeight.w600),
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('places')
                                .doc(widget.id)
                                .get()
                                .asStream(),
                            builder: (context, snapshot) {
                              List<dynamic> ids=[];
                              bool liked=false;
                              snapshot.data?['likedby']!=null? ids = snapshot.data!['likedby']:ids=[];
                              ids.contains(FirebaseAuth.instance.currentUser!.uid)?liked=true:liked=false;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    liked=!liked;
                                  });
                                  LikeItem(snapshot);

                                },
                                child: liked
                                    ? Icon(Icons.favorite,
                                        color: Color.fromARGB(255, 221, 28, 15),
                                        size: 30)
                                    : Icon(Icons.favorite_border,
                                        color: Color.fromARGB(255, 221, 28, 15),
                                        size: 30),
                              );
                            })
                      ],
                    ),
                    Row(
                      children: [
                       Stack(
                          children: [
                            RatingBar.builder(
                              initialRating: widget.ratings,
                              updateOnDrag: false,
                              tapOnlyMode: false,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Expanded(child: InkWell(child: Container(height: 50,width:MediaQuery.of(context).size.width*0.65,))),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomWidget(
                            text: widget.ratings.toString(),
                            size: 15,
                            color: blue,
                            weight: FontWeight.w500),
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 12, bottom: 12),
                      child: CustomWidget(
                          text: widget.description,
                          size: 11,
                          color: Color.fromARGB(141, 2, 10, 16),
                          weight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomWidget(
                        text: "Contact",
                        size: 20,
                        color: blue,
                        weight: FontWeight.w600),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, color: blue),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: (){
                            launch("tel://${widget.phone}");
                          },
                          child: CustomWidget(
                              text: widget.phone,
                              size: 12,
                              color: blue,
                              weight: FontWeight.normal),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.mail, color: blue),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: ()async{
                            final Email email = Email(
                              body: 'Hi! Daxno',
                              subject: 'Hi! Daxno,',
                              recipients: ['${widget.email}'],
                              isHTML: false,
                            );

                            await FlutterEmailSender.send(email);
                          },
                          child: CustomWidget(
                              text: widget.email,
                              size: 12,
                              color: blue,
                              weight: FontWeight.normal),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        openMap(widget.location);
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            height: 50,
                            width: 160,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.directions,
                                    color: blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CustomWidget(
                                      text: "Get Directions",
                                      size: 16,
                                      color: blue,
                                      weight: FontWeight.normal),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
  LikeItem(AsyncSnapshot snapshot)async{

      var data = FirebaseFirestore.instance
          .collection('places')
          .doc(widget.id)
          .get();

        List<dynamic> ids=[];
        snapshot.data?['likedby']!=null? ids = snapshot.data!['likedby']:ids=[];
        if(!ids.contains(FirebaseAuth
            .instance.currentUser!.uid)) {
          FirebaseFirestore.instance
              .collection('places')
              .doc(widget.id)
              .update({
            'likedby': FieldValue.arrayUnion([
              FirebaseAuth
                  .instance.currentUser!.uid
            ])
          });
        } else {
          FirebaseFirestore.instance
              .collection('places')
              .doc(widget.id)
              .update({
            'likedby': FieldValue.arrayRemove([
              FirebaseAuth
                  .instance.currentUser!.uid
            ])
          });
        }
  }
  static Future<void> openMap(LocationData ld) async {
    String homeLat = ld.latitude.toString();
    String homeLng = ld.longitude.toString();

    String googleUrl = 'https://www.google.com/maps/@${homeLat},${homeLng},12z';
    await launch(googleUrl);
    if (await canLaunch(googleUrl)) {
    } else {
      throw 'Could not open the map.';
    }
  }
  launchURL(LocationData ld) async {
    String homeLat = ld.latitude.toString();
    String homeLng = ld.longitude.toString();

    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunchUrl(Uri.parse(encodedURl))) {
      await launchUrl(Uri.parse(encodedURl));
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
}
