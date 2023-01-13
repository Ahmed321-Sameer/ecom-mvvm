import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvm_project/views/Admin/AddProduct.dart';
import 'package:mvvm_project/views/user/Customer%20account/Userlogin.dart';
import 'package:mvvm_project/views/user/User%20home%20/aboutus.dart';
import 'package:mvvm_project/views/user/User%20home%20/contactus.dart';

import '../widgets/Allproduct.dart';
import '../widgets/Banner.dart';
import '../widgets/Newarrival.dart';
import 'Track order/tabbar.dart';

class Userhome extends StatefulWidget {
  @override
  _UserhomeState createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffoldKey = GlobalKey();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: Text("Home"),
          elevation: 0,
        ),
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                onTap: () {},
                title: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          firebaseAuth.currentUser!.email.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 50,
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

              Baanner(),
              //baaanner caall
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                children: const [
                  Text(
                    "All Products",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              AllProduct(),
            ],
          ),
        ));
  }
}
