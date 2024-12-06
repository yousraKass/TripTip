import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Preference_widget.dart'; // Ensure PreferenceCell is properly defined here

class MyCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const MyCarousel({Key? key, required this.data}) : super(key: key);

  List<Map<String, dynamic>> user_preferences(){
    return data.where((item) => item["selected"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false, // No auto-scrolling
        enlargeCenterPage: false, // Keep all items the same size
        enableInfiniteScroll: false, // Prevent infinite scrolling
        scrollDirection: Axis.horizontal, // Carousel scrolls horizontally
        viewportFraction: 0.5, // Adjust this value to fit multiple items on screen
      ),
      items: user_preferences().map((item) {
        return Builder(
          builder: (BuildContext context) {
            return PreferenceCell(context, item, "profile"); // Ensure PreferenceCell is implemented correctly
          },
        );
      }).toList(),
    );
  }
}
