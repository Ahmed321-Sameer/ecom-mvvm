import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_project/views/Admin/admin.dart';
import 'package:mvvm_project/views/user/User%20home%20/user-home.dart';

import '../../Admin/AddProduct.dart';
import '../User home /bottomnavigation.dart';
import 'User-register.dart';

class Userlogin extends StatefulWidget {
  Userlogin({Key? key}) : super(key: key);

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  TextEditingController nameController =
      TextEditingController(text: "ahmed@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "12345678");

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: Colors.blue,
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
                    ),
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
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
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
                                      password: passwordController.text.trim())
                                  .then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Bottomsheet()),
                                    ),
                                  );
                            }
                          }).then((value) async {
                            print("check seller");
                            await FirebaseFirestore.instance
                                .collection('seller')
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
                                    backgroundColor: Colors.blue[900],
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
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Admin()));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: const Center(
                        child: Text(
                      "Admin Use",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
