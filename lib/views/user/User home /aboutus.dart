import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("About Us"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              //  AssetImage('assets/header_img1.png');
              Text(
                "Established in 2003, Mybrand is a fashion brand created for the spirited youth of Pakistan who enjoy indulging in the latest lifestyle trends; be it style, music, technology or social networking, as a means to express themselves.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Morbi et arcu vel risus aliquet ultricies in non odio. Quisque non mattis ante.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
