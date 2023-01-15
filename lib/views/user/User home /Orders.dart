import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/constants.dart';
import 'package:mvvm_project/views/user/widgets/cart.dart';

class Orders extends StatelessWidget {
  String product_name;
  String product_img;
  String promo_code;
  String product_price;
  String consumer_name;

  Orders(
      {required this.product_img,
      required this.product_name,
      required this.product_price,
      required this.promo_code,
      required this.consumer_name});
  final numbercontroller = TextEditingController();
  final addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text("Orders"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(" Please enter your info"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: numbercontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "enter your number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          //color: Colors.red[800]!,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addresscontroller,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: "enter your address",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          //color: Colors.red,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // FirebaseFirestore.instance
                  //     .collection("order")
                  //     .doc()
                  //     .collection("order list")
                  //     .doc()
                  //     .update({
                  //   "consumer_phone": numbercontroller.text.toString(),
                  //   "address": addresscontroller.text.toString(),
                  // }).then((value) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Userhome(),
                  //     ),
                  //   );
                  // }).then((value) {

                  cart.Product_name.remove;
                  cart.product_image.remove;
                  cart.product_price.remove;
                  cart.quantity.remove;
                  // }).then((value) => print("empty cart")
                },
                child: Container(
                  color: Colors.blue[900],
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
