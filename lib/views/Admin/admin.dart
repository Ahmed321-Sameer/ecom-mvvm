import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm_project/views/Admin/AddProduct.dart';
import 'package:mvvm_project/views/Admin/Orders/View_Orders.dart';
import 'package:mvvm_project/views/user/User%20home%20/utils/constants.dart';

import '../user/Customer account/Userlogin.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Userlogin()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: PrimaryColor,
          title: Text("Admin"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 170),
            child: Column(
              children: [
                Container(
                  color: PrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Upload_Products()));
                      },
                      child: Text(
                        "Add Product",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  color: PrimaryColor,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewOrders()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text(
                        "Orders",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
