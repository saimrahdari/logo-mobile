import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logo/views/pages/personal_profile_view.dart';

import '../../constants/firebase.dart';
import '../constants/styles.dart';
import '../widgets/widget.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: navBar(context, 4),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                    text: "FAQ",
                    size: 28,
                    color: blue,
                    weight: FontWeight.w700),
                ////////
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('What is logo App?',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('It\'s a smart app solution for user to find restaurants, hotels, events, location, dinign at one platform without visitng different apps. User can simply register and then start browsing around him.',
                            style: TextStyle(
                              color: Colors.indigo.shade200,
                              fontSize: 12,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ///////
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('What does subscription do?',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('It\'s a smart app solution for user to find restaurants, hotels, events, location, dinign at one platform without visitng different apps. User can purchase a subscription and can browse with out limits.',
                            style: TextStyle(
                              color: Colors.indigo.shade200,
                              fontSize: 12,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('How to get refund?',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('It\'s a smart app solution for user to find restaurants, hotels, events, location, dinign at one platform without visitng different apps. User can simply contact at support@logoapp.com for refund with purchase id.',
                            style: TextStyle(
                              color: Colors.indigo.shade200,
                              fontSize: 12,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ///////
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('What if I got scammed?',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('It\'s a smart app solution for user to find restaurants, hotels, events, location, dinign at one platform without visitng different apps. All the services on the platform are provided from verified publishers as we take security measures strictly for the best services. .',
                            style: TextStyle(
                              color: Colors.indigo.shade200,
                              fontSize: 12,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('What payment methods do you accept?',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('We accept different payment methods like Visa & master Debit/Credit cards, Stripe, Apple Pay, Google pay, bank transfer, Crypto. You can contact us any time for more related information at support@logoapp.com',
                            style: TextStyle(
                              color: Colors.indigo.shade200,
                              fontSize: 12,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
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
