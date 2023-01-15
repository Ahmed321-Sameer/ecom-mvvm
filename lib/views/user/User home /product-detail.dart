import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/constants.dart';
import 'package:mvvm_project/views/user/User%20home%20/viewcart.dart';
import 'package:mvvm_project/views/user/widgets/cart.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  int index;
  String prname;
  String primg;
  String price;
  // String promo;
  // String business_name;
  // String selleruid;
  List fvrt;
  String uid;
  // String seller_number;
  // String prquantity;
  ProductPage({
    required this.index,
    // required this.seller_number,
    required this.primg,
    required this.prname,
    required this.price,
    required this.fvrt,
    required this.uid,
    // required this.promo,
    // required this.business_name,
    // required this.prquantity,
    // required this.selleruid
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool likeornot = false;
  @override
  void initState() {
    super.initState();
    loadcondition();
  }

  loadcondition() {
    if (widget.fvrt.contains(FirebaseAuth.instance.currentUser!.uid)) {
      setState(() {
        likeornot = true;
      });
    }
  }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => viewcart(
                        // business_name: widget.business_name,
                        // seller_number: widget.seller_number,
                        ),
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(right: 5, top: 10),
              child: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 35,
                  ),
                  Positioned(
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: PrimaryColor),
                      child: Center(
                          child: Text(
                        cart.quantity.length.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        child: Hero(
                          tag: widget.index,
                          child: Image(
                              image: NetworkImage(widget.primg),
                              height: 250,
                              // width: 350,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.prname,
                          style: const TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (likeornot) {
                              setState(() {
                                likeornot = false;
                              });
                            } else {
                              setState(() {
                                likeornot = true;
                              });
                            }

                            if (!likeornot) {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(widget.uid)
                                  .update({
                                'faavorite': FieldValue.arrayRemove(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(widget.uid)
                                  .update({
                                'faavorite': FieldValue.arrayUnion(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                            }
                          },
                          child: Icon(
                            Icons.favorite_sharp,
                            color: likeornot ? Colors.red : Colors.grey,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Rs${widget.price}",
                            style: const TextStyle(
                              color: PrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cart.checkproduct(widget.primg).then((value) {
                            if (value) {
                              print("product already exist");
                              Fluttertoast.showToast(
                                  msg: "Product already exist",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: PrimaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              setState(() {
                                cart.quantity.length;
                              });
                              print("product is added to the list");
                              cart.product_price.add(widget.price);
                              cart.Product_name.add(widget.prname);
                              cart.product_image.add(widget.primg);

                              cart.quantity.add(quantity);
                              Fluttertoast.showToast(
                                  msg: "Product Add",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: PrimaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PrimaryColor),
                          child: const Center(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                fontFamily: "new",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
