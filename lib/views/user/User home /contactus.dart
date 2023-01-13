import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class ContctUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          child: ContactUs(
            logo: AssetImage('assets/header_img1.png'),
            email: 'mybrand@gmail.com',
            companyName: 'Mybrand',
            phoneNumber: '+92123456789',
            dividerThickness: 2,
            dividerColor: Colors.blue[700],
            website: 'https://abhishekdoshi.godaddysites.com',
            cardColor: Colors.grey[400]!,
            companyColor: Colors.blue[900]!,
            taglineColor: Colors.white30,
            textColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
