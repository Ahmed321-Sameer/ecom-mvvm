import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../view_models/product_viewmodel.dart';
import '../User home /product-detail.dart';

class AllProduct extends StatelessWidget {
  AllProduct({Key? key}) : super(key: key);
  // final studentViewModel = Get.put(StudentViewModel());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return Container(
            margin: const EdgeInsets.all(12),
            child: MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot curdoc = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    print("object");
                    List favrt = [];
                    favrt = curdoc.get("faavorite");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                  index: index,
                                  primg: curdoc["imagelink"],
                                  prname: curdoc["name"],
                                  price: curdoc["price"],
                                  // promo: curdoc["promo code"],
                                  // business_name: curdoc["business_name"],
                                  fvrt: favrt,
                                  uid: curdoc.id,
                                  // selleruid: curdoc["seller_id"],
                                  // seller_number: curdoc["seller_number"],
                                  // prquantity: curdoc["quantity"],
                                  // prname: curdoc["item name"],
                                  // price: curdoc["price"],
                                  // description: curdoc["item description"],
                                )));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: Hero(
                            tag: index,
                            child: Image(
                              image: NetworkImage(curdoc["imagelink"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(curdoc["name"]),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Text(
                                curdoc["description"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:loading_overlay/loading_overlay.dart';

// import '../../../view_models/product_viewmodel.dart';
// import '../User home /product-detail.dart';

// class AllProduct extends StatelessWidget {
//   AllProduct({Key? key}) : super(key: key);
//   final productViewModel = Get.put(ProductViewModel());
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => LoadingOverlay(
//         isLoading: productViewModel.isLoading.value,
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           // crossAxisCount: 2,
//           // crossAxisSpacing: 12,
//           // mainAxisSpacing: 12,
//           itemCount: productViewModel.allProductList.length,
//           itemBuilder: (context, index) {
//             // DocumentSnapshot curdoc = snapshot.data!.docs[index];
//             return GestureDetector(
//               onTap: () {
//                 print("object");
//                 List favrt = [];
//                 // favrt = curdoc.get("faavorite");
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ProductPage(
//                               index: index,
//                               primg: productViewModel
//                                   .allProductList[index].imagelink!,
//                               prname:
//                                   productViewModel.allProductList[index].name!,
//                               price:
//                                   productViewModel.allProductList[index].price!,
//                               // promo: curdoc["promo code"],
//                               // business_name: curdoc["business_name"],
//                               // fvrt: favrt,
//                               // uid: curdoc.id,
//                               // selleruid: curdoc["seller_id"],
//                               // seller_number: curdoc["seller_number"],
//                               // prquantity: curdoc["quantity"],
//                               // prname: curdoc["item name"],
//                               // price: curdoc["price"],
//                               // description: curdoc["item description"],
//                             )));
//               },
//               child: Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(12))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(12),
//                           topRight: Radius.circular(12)),
//                       child: Hero(
//                         tag: index,
//                         child: Image(
//                           image: NetworkImage(productViewModel
//                               .allProductList[index].imagelink!),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   padding: const EdgeInsets.symmetric(
//                     //       horizontal: 10, vertical: 5),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       Text(productViewModel.allProductList[index].name!),
//                     //       SizedBox(
//                     //           height:
//                     //               MediaQuery.of(context).size.height * 0.01),
//                     //       Text(
//                     //         productViewModel
//                     //             .allProductList[index].description!,
//                     //         style: const TextStyle(
//                     //           fontWeight: FontWeight.w700,
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
