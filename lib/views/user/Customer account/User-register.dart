import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_project/views/Admin/AddProduct.dart';
import 'package:mvvm_project/views/Admin/admin.dart';
import 'package:mvvm_project/views/user/Customer%20account/Userlogin.dart';

import '../User home /bottomnavigation.dart';
import '../User home /user-home.dart';
import '../User home /utils/constants.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 60),
                        child: const Text(
                          'Register Your Account',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: PrimaryColor,
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                            focusColor: PrimaryColor,
                            hoverColor: PrimaryColor,
                            fillColor: PrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: PrimaryColor,
                        controller: emailController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: PrimaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(),
                            fillColor: PrimaryColor,
                            focusColor: PrimaryColor,
                            hoverColor: PrimaryColor,
                            prefixIconColor: PrimaryColor,
                            labelText: 'Email'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: PrimaryColor,
                          focusColor: PrimaryColor,
                          hoverColor: PrimaryColor,
                          labelText: 'Password',
                        ),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Enter more then 6 number";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Userlogin()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: PrimaryColor),
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: TextButton(
                          child: const Text('Register',
                              style: TextStyle(
                                  backgroundColor: PrimaryColor,
                                  fontSize: 20,
                                  color: Colors.white)),
                          onPressed: () async {
                            try {
                              await firebaseAuth
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim())
                                  .then(
                                (value) {
                                  FirebaseFirestore.instance
                                      .collection("consumer")
                                      .doc(value.user!.uid)
                                      .set({
                                    "name": nameController.text.trim(),
                                    "email": emailController.text.trim(),
                                    "id": value.user!.uid,
                                  }).then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Bottomsheet()),
                                    ),
                                  );
                                },
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Fluttertoast.showToast(
                                    msg: "The password provided is too weak.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.amber,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              } else if (e.code == 'email-already-in-use') {
                                Fluttertoast.showToast(
                                    msg:
                                        "The account already exists for that email.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: PrimaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: PrimaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Already Have account..?',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: PrimaryColor, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Userlogin()));
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
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Admin()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
