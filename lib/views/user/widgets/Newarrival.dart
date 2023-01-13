import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../User home /Seller_product.dart';

class NewArrival extends StatelessWidget {
  NewArrival({Key? key}) : super(key: key);
  List<String> imageList = [
    'assets/all_products1.png',
    'assets/all_products2.png',
    'assets/all_products3.png',
    'assets/all_products4.png',
    'assets/all_products1.png',
    'assets/all_products2.png',
    'assets/all_products3.png',
    'assets/all_products4.png',
    'assets/all_products1.png',
    'assets/all_products2.png',
    'assets/all_products3.png',
    'assets/all_products4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      // MediaQuery.of(context).size.height * 0.13,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("seller").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerProduct(
                          id: data['id'],
                          busines_name: data['busines-name'],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        // maxRadius: 25,
                        radius: 25,
                        child: Image(
                          image: AssetImage(imageList[index]),
                        ),
                      ),
                      Text(
                        data['busines-name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
