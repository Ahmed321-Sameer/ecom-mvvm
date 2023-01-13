import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Pendingorders extends StatefulWidget {
  const Pendingorders({Key? key}) : super(key: key);

  @override
  State<Pendingorders> createState() => _PendingordersState();
}

class _PendingordersState extends State<Pendingorders> {
  // getOrderindex() {
  //   FirebaseFirestore.instance
  //       .collection("consumer")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get().then((value) {
  //         value.get("field")
  //       })

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("order")
              .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("No Order placed yet",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Order placed yet",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                }
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.grey[800]!,
                      Colors.grey[600]!,
                      Colors.grey[400]!,
                      Colors.grey[200]!,
                    ]),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // Row(
                      //   children: [
                      //     const Text(
                      //       "consumer name : ",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white),
                      //     ),
                      //     Spacer(),
                      //     Text(
                      //       documentSnapshot.get("consumer_name"),
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Total Price : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            documentSnapshot.get("total price"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       "Pending items : ",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white),
                      //     ),
                      //     const Spacer(),
                      //     Text(
                      //       documentSnapshot.get("total item"),
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: ExpansionTile(
                          title: Text(
                            "View details",
                            style: TextStyle(color: Colors.white),
                          ),
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: documentSnapshot.reference
                                    .collection("order list")
                                    .snapshots(),
                                builder: ((context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: ((context, index) {
                                        var values = snapshot.data!.docs[index];
                                        return Container(
                                          margin: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              values[
                                                                  "product_image"]),
                                                          fit: BoxFit.fill),
                                                      shape: BoxShape.circle),
                                                ),
                                                const Divider(
                                                  color: Colors.white,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "product name : ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      values
                                                          .get("product_name"),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "product price : ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      values
                                                          .get("product_price"),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     const Text(
                                                //       "business name : ",
                                                //       style: TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold,
                                                //           color: Colors.white),
                                                //     ),
                                                //     const Spacer(),
                                                //     Text(
                                                //       values.get("market name"),
                                                //     )
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                }))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
