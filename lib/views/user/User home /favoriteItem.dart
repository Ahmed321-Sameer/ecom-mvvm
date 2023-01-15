import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bottomnavigation.dart';
import 'utils/constants.dart';

class FavoriteItems extends StatefulWidget {
  @override
  _FavoriteItemsState createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Bottomsheet()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),

            backgroundColor: PrimaryColor,
            centerTitle: true,
            title: Text("Favorite"),
            // backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("faavorite",
                      arrayContains: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Fluttertoast.showToast(msg: 'error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var values = snapshot.data!.docs[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          child: Center(
                            child: Image(
                              image: NetworkImage(
                                values['imagelink'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(values['name']),
                        subtitle: Text(values['description']),
                        trailing: FavoriteButton(
                            isFavorite: true,
                            valueChanged: (_) {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(values.id)
                                  .update({
                                "faavorite": FieldValue.arrayRemove(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                            }),
                      ),
                    );
                  },
                );
              },
            ),
          )),
    );
  }
}
