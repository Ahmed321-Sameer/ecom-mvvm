import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/views/Admin/Orders/View_Orders.dart';

class Order_Detail extends StatefulWidget {
  String snapshot_id;
  Order_Detail({Key? key, required this.snapshot_id}) : super(key: key);
  @override
  State<Order_Detail> createState() => _Order_DetailState();
}

class _Order_DetailState extends State<Order_Detail> {
  @override
  void initState() {
    // TODO: implement initState
    // print(widget.busines_name);
    super.initState();
  }

  cameradialog(DocumentSnapshot productdata, int snapshot_length,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    AwesomeDialog(
        customHeader: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(productdata.get("product_image")))),
        ),
        context: context,
        dialogBackgroundColor: Colors.black,
        dialogType: DialogType.SUCCES,
        borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
        width: 380,
        buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        body: Column(
          children: [
            const Text('Details',
                style: TextStyle(
                    color: Colors.orange, fontFamily: "new", fontSize: 22)),
            Text("Pr.Name: " + productdata["product_name"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "new",
                )),
            Text("Pr.price: " + productdata["product_price"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "new",
                )),
            Text("Status: " + productdata["order status"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "new",
                )),
            Text("Number: " + productdata["consumer_phone"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "new",
                )),
          ],
        ),
        btnOkText: "Accept order",
        btnCancelText: "Deny",
        btnCancelOnPress: () async {
          await FirebaseFirestore.instance.collection("Order history").add({
            "order status": "rejected",
            // "promo_code": productdata['product_code'],
            "product_name": productdata['product_name'],
            "address": productdata['address'],
            "product_price": productdata["product_price"],
            "product_image": productdata['product_image'],
            "consumer_name": productdata['consumer_name'],
            // "busines_name": productdata['market name'],
            // "user_id": productdata['id'],
            // "seller_id": FirebaseAuth.instance.currentUser!.uid.toString()
          }).then((value) {
            FirebaseFirestore.instance
                .collection("order")
                .doc(widget.snapshot_id)
                .get()
                .then((value) async {
              await value.reference
                  .collection("order list")
                  .get()
                  .then((chlidvalue) async {});
            });
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection("order")
                .doc(widget.snapshot_id)
                .collection("order list")
                .doc()
                .delete();
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection("order")
                .doc(widget.snapshot_id)
                .collection("order list")
                .get()
                .then((value) async {
              if (value.size == 0) {
                await FirebaseFirestore.instance
                    .collection("order")
                    .doc(widget.snapshot_id)
                    .delete();
              }
            });
          });
        },
        showCloseIcon: true,
        btnOkOnPress: () async {
          FirebaseFirestore.instance.collection("Products").get();

          // FirebaseFirestore.instance
          //     .collection("Products")

          //     .get()
          //     .then((value) {
          //   value.docs.forEach((element) {
          //     element.reference.update({
          //       "quantity": (int.parse(element.get("quantity")) -
          //               int.parse(productdata["quantity"]))
          //           .toString()
          //     });
          //   });
          // }).then((value) {
          //   FirebaseFirestore.instance
          //       .collection("seller")
          //       .doc(productdata.get("seller uid"))
          //       .collection("seller item")
          //       .where("promo code", isEqualTo: productdata["product_code"])
          //       .get()
          //       .then((value) {
          //     value.docs.forEach((element) {
          //       print("here is element name" + element.get("item name"));
          //       element.reference.update({
          //         "quantity": (int.parse(element.get("quantity")) -
          //                 int.parse(productdata["quantity"]))
          //             .toString()
          //       });
          //     });
          //   }).then((value) async {
          //     await FirebaseFirestore.instance
          //         .collection("order")
          //         .doc(widget.snapshot_id)
          //         .get()
          //         .then((value) async {
          //       await value.reference
          //           .collection("order list")
          //           .where("market name", isEqualTo: widget.busines_name)
          //           .get()
          //           .then((chlidvalue) async {
          //         if (chlidvalue.size - 1 >= 1) {
          //           print("company product still exisist ");
          //         } else {
          //           await value.reference.update({
          //             "busines_name":
          //                 FieldValue.arrayRemove([widget.busines_name])
          //           });
          //         }
          //       }).then((value) async {
          //         await FirebaseFirestore.instance
          //             .collection("Order history")
          //             .add({
          //           "order status": "accepted",
          //           "day": "${DateTime.now().day}",
          //           "month": "${DateTime.now().month}",
          //           "seller_number": productdata["seller_number"],
          //           "promo_code": productdata['product_code'],
          //           "address": productdata['address'],
          //           "consumer_phone": productdata["consumer_phone"],
          //           "quantity": productdata['quantity'],
          //           "product_name": productdata['product_name'],
          //           "product_price": productdata["product_price"],
          //           "product_image": productdata['product_image'],
          //           "consumer_name": productdata['consumer_name'],
          //           "busines_name": productdata['market name'],
          //           "user_id": productdata['id'],
          //           "seller_id":
          //               FirebaseAuth.instance.currentUser!.uid.toString()
          //         }).then((value) async {
          //           await FirebaseFirestore.instance
          //               .collection("order")
          //               .doc(widget.snapshot_id)
          //               .collection("order list")
          //               .doc(productdata.id)
          //               .delete();
          //         }).then((value) async {
          //           await FirebaseFirestore.instance
          //               .collection("order")
          //               .doc(widget.snapshot_id)
          //               .collection("order list")
          //               .get()
          //               .then((value) async {
          //             if (value.size == 0) {
          //               await FirebaseFirestore.instance
          //                   .collection("order")
          //                   .doc(widget.snapshot_id)
          //                   .delete();
          //             }
          //           });
          //         });
          //       });
          //     });
          //   });
          // });
        }).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewOrders()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue[900],
        title: Text("Order Detail"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("order")
            .doc(widget.snapshot_id)
            .collection("order list")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var value = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  cameradialog(value, snapshot.data!.size, snapshot);
                },
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(value["product_image"]),
                          radius: 40,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Pr.name: ",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  value["product_name"],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Pr.price: ",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  value["product_price"],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Pr.quantity: ",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  value["quantity"].toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Addres: ",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  value["address"].toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(value["order status"]),
                      ],
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
