import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/constants.dart';
import 'package:mvvm_project/views/user/widgets/cart.dart';

import 'bottomnavigation.dart';

class viewcart extends StatefulWidget {
  @override
  String? business_name;
  String? seller_number;
  viewcart({this.business_name, this.seller_number});
  _viewcartState createState() => _viewcartState();
}

class _viewcartState extends State<viewcart> {
  String consumer = '';

  bool refresh = false;
  bool loadcontent = false;
  int length = 0;
  double totalprice = 0.0;

  @override
  void initState() {
    // getbusiness();
    length = cart.Product_name.length;
    if (length != 0) {
      setState(() {
        loadcontent = true;
      });
    }
    totalsum();
    super.initState();
  }

  totalsum() {
    totalprice = 0.0;
    for (int i = 0; i < cart.quantity.length; i++) {
      setState(() {
        totalprice =
            totalprice + (cart.quantity[i] * int.parse(cart.product_price[i]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Bottomsheet()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: PrimaryColor,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey[300]!,
              offset: Offset(0, 0),
            )
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      totalprice.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
                color: PrimaryColor, borderRadius: BorderRadius.circular(30)),
            child: GestureDetector(
              onTap: () {
                getuserifno();
              },
              child: const Text(
                "Place Order",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ]),
      ),
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            child: !refresh && loadcontent
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemCount: cart.Product_name.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Hero(
                                      tag: index,
                                      child: CircleAvatar(
                                        maxRadius: 50,
                                        backgroundColor: Colors.white,
                                        child: Image(
                                          image: NetworkImage(
                                              cart.product_image[index]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cart.Product_name[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            (cart.quantity[index] *
                                                    int.parse(
                                                      cart.product_price[index],
                                                    ))
                                                .toString(),
                                            style: const TextStyle(
                                                color: PrimaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        // Text(
                                        //     ("by: " + cart.marketbrands[index]),
                                        //     style: const TextStyle(
                                        //         fontWeight: FontWeight.bold,
                                        //         fontSize: 15)),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    // delete button
                                    IconButton(
                                        onPressed: () {
                                          cart.Product_name.removeAt(index);
                                          cart.product_image.removeAt(index);
                                          cart.product_price.removeAt(index);
                                          cart.quantity.removeAt(index);

                                          setState(() {
                                            cart.quantity.length;
                                            if (cart.Product_name.length == 0) {
                                              loadcontent = false;
                                            }
                                            refresh = true;
                                            refresh = false;
                                          });
                                          totalsum();
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red)),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                print(cart.quantity[index]);
                                                cart.quantity[index]++;
                                              });
                                              totalsum();
                                            },
                                            icon: Icon(Icons.add)),
                                        Text(cart.quantity[index].toString()),
                                        IconButton(
                                            onPressed: () {
                                              if (cart.quantity[index] > 1) {
                                                setState(() {
                                                  cart.quantity[index]--;
                                                });
                                                totalsum();
                                              }
                                            },
                                            icon: Icon(Icons.remove)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      "Cart is empty",
                      style: TextStyle(
                        fontSize: 40,
                        color: PrimaryColor,
                      ),
                    ),
                  )),
      ),
    );
  }

  final numbercontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final codecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  getuserifno() {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Colors.white,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const Text('complete this form',
                style: TextStyle(
                    color: Colors.orange, fontFamily: "new", fontSize: 22)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: numbercontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "enter your number",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
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
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: addresscontroller,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  // fillColor: Colors.white,
                  hintText: "enter your address",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
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
                controller: codecontroller,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  // fillColor: Colors.white,
                  hintText: "enter consession code",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      btnOkText: "send order",
      btnCancelText: "Deny",
      showCloseIcon: true,
      btnOkOnPress: () async {
        if (formkey.currentState!.validate()) {
          if (cart.Product_name.isNotEmpty) {
            await FirebaseFirestore.instance.collection("order").add({
              "total item": cart.quantity.length.toString(),
              "total price": totalprice.toString(),
              // "busines_name": cart.brandslisttoupload,
              "consumer_name": consumer,
              "seller_number": widget.seller_number,
              "consumer_phone": numbercontroller.text.toString(),
              "id": FirebaseAuth.instance.currentUser!.uid
            }).then((value) async {
              print("now for loop is about to laounch");
              for (int i = 0; i < cart.quantity.length; i++) {
                print("number alterations $i");
                await FirebaseFirestore.instance
                    .collection("order")
                    .doc(value.id)
                    .collection("order list")
                    .add({
                  "quantity": cart.quantity[i].toString(),
                  // "market name": cart.marketbrands[i],
                  "product_name": cart.Product_name[i],
                  "product_price": cart.product_price[i],
                  "product_image": cart.product_image[i],
                  // "product_code": cart.promo_code[i],
                  "consumer_phone": numbercontroller.text.toString(),
                  "seller_number": widget.seller_number,
                  "order status": "pending",
                  // "seller uid": cart.selleruid[i],
                  "address": addresscontroller.text.toString(),
                  "consumer_name": consumer.toString(),
                  "id": FirebaseAuth.instance.currentUser!.uid
                });
              }
            }).then((value) {
              cart.Product_name.clear();
              cart.product_image.clear();
              cart.quantity.clear();
            }).then((value) {
              Fluttertoast.showToast(
                  msg: "Order placed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Bottomsheet()));
            });
            ;
          } else {
            print("Complete your form first");
          }
        } else {
          Fluttertoast.showToast(
              msg: "Order placed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    ).show();
  }
}
