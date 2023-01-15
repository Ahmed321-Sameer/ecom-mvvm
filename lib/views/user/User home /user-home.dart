import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvm_project/views/Admin/AddProduct.dart';
import 'package:mvvm_project/views/user/Categorypages/AllJackets.dart';
import 'package:mvvm_project/views/user/Categorypages/AllPants.dart';
import 'package:mvvm_project/views/user/Categorypages/AllShoes.dart';
import 'package:mvvm_project/views/user/Customer%20account/Userlogin.dart';
import 'package:mvvm_project/views/user/User%20home%20/aboutus.dart';
import 'package:mvvm_project/views/user/User%20home%20/contactus.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/Categories.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/constants.dart';

import '../widgets/Allproduct.dart';
import '../widgets/Banner.dart';
import '../widgets/Newarrival.dart';
import 'utils/size_config.dart';
import 'Track order/tabbar.dart';

class Userhome extends StatefulWidget {
  @override
  _UserhomeState createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/tshirt.svg", "text": "Shirts"},
      {"icon": "assets/jacket_1.svg", "text": "Jackets"},
      {"icon": "assets/jeans.svg", "text": "Pants"},
      {"icon": "assets/sneaker.svg", "text": "Shoes"},
    ];
    GlobalKey _scaffoldKey = GlobalKey();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: PrimaryColor,
            centerTitle: true,
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0,
          ),
          key: _scaffoldKey,
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                Container(
                  height: 150,
                  color: PrimaryColor,
                  child: Center(
                    child: ListTile(
                      onTap: () {},
                      title: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey[300],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            firebaseAuth.currentUser!.email.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => View(),
                        ));
                  },
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text("order"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  leading: const Icon(Icons.accessibility_new_outlined),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContctUs()));
                  },
                  leading: const Icon(Icons.contact_page),
                  title: const Text("Contact page"),
                ),
                ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Userlogin()));
                    });
                  },
                  leading: const Icon(Icons.logout_sharp),
                  title: const Text("Logout"),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Categories(),
                SizedBox(height: 5),
                Baanner(),
                //baaanner caall
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Shirts",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllJackets(),
                              ));
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: PrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                AllProduct(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Jackets",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllJackets(),
                              ));
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: PrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Jackets(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Pants",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllPants(),
                              ));
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: PrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Pants(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Shoes",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllShoes(),
                              ));
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: PrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Shoes()
              ],
            ),
          )),
    );
  }
}
