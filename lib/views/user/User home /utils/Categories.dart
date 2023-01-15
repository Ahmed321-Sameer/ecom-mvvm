import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';
import 'size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/tshirt.svg", "text": "Tshirts"},
      {"icon": "assets/jacket_1.svg", "text": "Jackets"},
      {"icon": "assets/jeans.svg", "text": "Pants"},
      {"icon": "assets/sneaker.svg", "text": "Shoes"},
    ];
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              // Navigator.pushNamed(
              //   context,
              //   CategoryScreen.routeName,
              //   arguments: CategoryDetailsArguments(
              //     category: categories[index]["text"],
              //   ),
              // );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryDetailsArguments {
  final String category;
  CategoryDetailsArguments({required this.category});
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    // required Key key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 50,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: PrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                icon,
                height: 20.0,
                width: 20.0,
                allowDrawingOutsideViewBox: true,
                color: PrimaryColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'PantonBold',
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
