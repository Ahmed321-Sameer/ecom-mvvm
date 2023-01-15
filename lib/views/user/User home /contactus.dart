import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/constants.dart';

class ContctUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PrimaryColor,
        title: Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          child: ContactUs(
            logo: AssetImage('assets/logo1.PNG'),
            email: 'mybrand@gmail.com',
            companyName: 'Mybrand',
            phoneNumber: '+92123456789',
            dividerThickness: 2,
            dividerColor: PrimaryColor,
            website: 'https://abhishekdoshi.godaddysites.com',
            cardColor: PrimaryColor,
            companyColor: PrimaryColor,
            taglineColor: Colors.white30,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
