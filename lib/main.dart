import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/views/user/Customer%20account/User-register.dart';
import 'package:mvvm_project/views/user/Customer%20account/Userlogin.dart';
import 'package:mvvm_project/views/user/User%20home%20/bottomnavigation.dart';
import 'package:mvvm_project/views/user/User%20home%20/user-home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? Bottomsheet()
          : Userlogin(),
    );
  }
}
