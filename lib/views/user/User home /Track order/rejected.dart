import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Rejectedorders extends StatelessWidget {
  const Rejectedorders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          //color: Colors.black.withOpacity(.7),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Order history")
                .where("user_id",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where("order status", isEqualTo: "rejected")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Order placed yet",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Order placed yet",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        PrimaryColor,
                        PrimaryColor.withOpacity(.7),
                        PrimaryColor.withOpacity(.8),
                        PrimaryColor.withOpacity(.9),
                      ]),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      documentSnapshot["product_image"]),
                                  fit: BoxFit.fill),
                              shape: BoxShape.circle),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Text(
                              "product: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Text(documentSnapshot.get("product_name"))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Prduct Price : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            Text(
                              documentSnapshot.get("product_price"),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Promo Code : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            Text(
                              documentSnapshot.get("promo_code"),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (documentSnapshot.get("order status") == "rejected")
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "this Order is canceled",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        if (documentSnapshot.get("order status") == "pending")
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "your order is pending",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        if (documentSnapshot.get("order status") == "accepted")
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "Successfully received",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
