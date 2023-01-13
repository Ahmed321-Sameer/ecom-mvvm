import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_project/models/product_model.dart';

class ProductViewModel extends GetxController {
  var isLoading = false.obs;
  var allProductList = <ProductModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllProduct();
  }

  fetchAllProduct() async {
    isLoading.value = true;
    allProductList.clear();
    await FirebaseFirestore.instance
        .collection("Products")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var u in snapshot.docs) {
        allProductList.add(ProductModel(
          id: u['id'],
          price: u['price'],
          name: u['name'],
          description: u['description'],
          imagelink: u['imagelink'],
        ));
      }
      if (allProductList != null) {
        isLoading.value = false;
      }
    });
  }

  addProduct(
      File profileImage, String name, String email, String password) async {
    isLoading.value = true;

    int uniqueId = DateTime.now().microsecondsSinceEpoch;
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("products/$uniqueId")
        .putFile(profileImage);
    TaskSnapshot snapshot = await uploadTask;
    String downloadImageUrl = await snapshot.ref.getDownloadURL();

    if (downloadImageUrl != null) {
      ProductModel productModel = ProductModel();
      productModel.id = uniqueId;
      productModel.name = name;
      productModel.price = email;
      productModel.description = password;
      productModel.imagelink = downloadImageUrl;

      FirebaseFirestore.instance
          .collection("Products")
          .doc(uniqueId.toString())
          .set(productModel.toMap())
          .then((value) {
        isLoading.value = false;
        fetchAllProduct();
        Get.snackbar("Product addition", "One Product added successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      }).catchError((error) {
        isLoading.value = false;
        Get.snackbar("Product addition", "One Product addition failed",
            colorText: Colors.white, backgroundColor: Colors.red);
      });
    }
  }

  updateProduct(File profileImage, String name, String email, String password,
      int id) async {
    isLoading.value = true;

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("Products/$id")
        .putFile(profileImage);
    TaskSnapshot snapshot = await uploadTask;
    String downloadImageUrl = await snapshot.ref.getDownloadURL();

    if (downloadImageUrl != null) {
      FirebaseFirestore.instance
          .collection("Products")
          .doc(id.toString())
          .update({
        'name': name,
        'email': email,
        'password': password,
        'image': downloadImageUrl,
      }).then((value) {
        isLoading.value = false;
        fetchAllProduct();
        Get.snackbar("Product updation", "One Product updated successfully",
            colorText: Colors.white, backgroundColor: Colors.green);
      }).catchError((error) {
        isLoading.value = false;
        Get.snackbar("Product updation", "One Product updation failed",
            colorText: Colors.white, backgroundColor: Colors.red);
      });
    }
  }

  deleteProduct(ProductModel productModel) async {
    allProductList.remove(productModel);
    await FirebaseFirestore.instance
        .collection("Products")
        .doc(productModel.id.toString())
        .delete()
        .then((value) {
      Get.snackbar("Product deletion", "One Product deleted successfully",
          colorText: Colors.white, backgroundColor: Colors.green);
    }).catchError((error) {
      Get.snackbar("Product deletion", "One Product deletion failed",
          colorText: Colors.white, backgroundColor: Colors.red);
    });
  }
}
