import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_project/views/Admin/admin.dart';
import 'package:mvvm_project/views/user/User%20home%20/user-home.dart';

import '../../Admin/AddProduct.dart';
import '../User home /bottomnavigation.dart';
import '../User home /utils/constants.dart';
import 'User-register.dart';

class Userlogin extends StatefulWidget {
  Userlogin({Key? key}) : super(key: key);

  @override
  State<Userlogin> createState() => _UserloginState();
}

final String admin = "admin";

class _UserloginState extends State<Userlogin> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adminController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  checkadmin() {
    AwesomeDialog(
        context: context,
        dialogBackgroundColor: Colors.white,
        dialogType: DialogType.SUCCES,
        borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
        width: 380,
        buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        body: Form(
          key: formkey2,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     validator: (val) {
              //       if (val!.isEmpty) {
              //         return "Required";
              //       } else {
              //         return null;
              //       }
              //     },
              //     controller: adminController,
              //     keyboardType: TextInputType.name,
              //     decoration: const InputDecoration(
              //       fillColor: Colors.black,
              //       hintText: "enter password",
              //       border: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black, width: 5.0),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        btnOkText: "Enter",
        btnCancelText: "cancel",
        btnCancelOnPress: () {
          print("hi");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Userlogin()));
        },
        showCloseIcon: true,
        btnOkOnPress: () {
          print("no1");
          // if (formkey2.currentState!.validate()) {
          // if (adminController == admin) {
          print("no2");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Admin()));
          // }
        }
        //  else {
        //   Fluttertoast.showToast(
        //           msg: "wrong Paassword",
        //           toastLength: Toast.LENGTH_SHORT,
        //           gravity: ToastGravity.CENTER,
        //           timeInSecForIosWeb: 1,
        //           backgroundColor: PrimaryColor,
        //           textColor: Colors.white,
        //           fontSize: 16.0)
        //       .then((value) => {});
        // }
        //},
        ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formkey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign In To continue',
                        style: TextStyle(
                            color: PrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          fillColor: PrimaryColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          fillColor: PrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: PrimaryColor),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        child: const Text('Login',
                            style: TextStyle(
                                backgroundColor: PrimaryColor,
                                fontSize: 20,
                                color: Colors.white)),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            print("check consumer");
                            await FirebaseFirestore.instance
                                .collection('consumer')
                                .where("email", isEqualTo: nameController.text)
                                .get()
                                .then((value) async {
                              if (value.docs.length > 0 &&
                                  value.docs.length < 2) {
                                await firebaseAuth
                                    .signInWithEmailAndPassword(
                                        email: nameController.text.trim(),
                                        password:
                                            passwordController.text.trim())
                                    .then(
                                      (value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Bottomsheet()),
                                      ),
                                    );
                              }
                            }).then((value) async {
                              print("check seller");
                              await FirebaseFirestore.instance
                                  .collection('seller')
                                  .where("email",
                                      isEqualTo: nameController.text)
                                  .get()
                                  .then((value) async {
                                if (value.docs.length > 0 &&
                                    value.docs.length < 2) {
                                  await firebaseAuth
                                      .signInWithEmailAndPassword(
                                          email: nameController.text.trim(),
                                          password:
                                              passwordController.text.trim())
                                      .then((value) => print("object")
                                          //  Navigator.pushReplacement(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           SellerNavBar()
                                          //           ),
                                          // ),
                                          );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "user not found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: PrimaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            });
                            print(nameController.text);
                          }
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: PrimaryColor, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if(""=""){}
                      checkadmin();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: PrimaryColor),
                      child: const Center(
                          child: Text(
                        "Admin Use",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
