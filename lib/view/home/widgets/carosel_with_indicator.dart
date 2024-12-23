import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CaroselWithIndicator extends StatefulWidget {
  final List<Widget> imags;
  const CaroselWithIndicator({super.key, required this.imags});

  @override
  State<CaroselWithIndicator> createState() => CaroselWithIndicatorState();
}

class CaroselWithIndicatorState extends State<CaroselWithIndicator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Ensure the carousel fills the entire width
        SizedBox(
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: widget.imags.length,
            itemBuilder: (context, index, realIndex) {
              return widget.imags[index];
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              viewportFraction: 1.0, // Each slide takes up the full width
              enlargeCenterPage: false, // Prevent enlarging the center slide
            ),
          ),
        ),
        // Dots indicator at the bottom
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.imags.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? AppColors.secondaryBlue
                      : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
