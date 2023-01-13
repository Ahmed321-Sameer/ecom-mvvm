import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Baanner extends StatelessWidget {
  Baanner({Key? key}) : super(key: key);
  int _current = 0;
  List carouselData = [
    "assets/header_img1.png",
    "assets/header_img1.png",
    "assets/header_img1.png",
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 11,
          height: MediaQuery.of(context).size.height * 0.20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: carouselData
                  .map(
                    (value) => Image(
                      image: AssetImage(value),
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(carouselData, (value, url) {
            return Container(
              width: _current == value ? 35.0 : 10,
              height: _current == value ? 10.0 : 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: _current == value
                    ? BorderRadius.circular(20)
                    : BorderRadius.circular(20),
                color: _current == value ? Colors.blue : Colors.grey[400],
              ),
            );
          }),
        ),
      ],
    );
  }
}
