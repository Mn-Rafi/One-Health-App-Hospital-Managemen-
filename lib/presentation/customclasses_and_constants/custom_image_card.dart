import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomImageCard extends StatelessWidget {
  final String imagePath;
  final double ratio;
  final double? width;
  const CustomImageCard({
    Key? key,
    required this.imagePath,
    required this.ratio,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: AspectRatio(
        aspectRatio: ratio,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomCircularImageCard extends StatelessWidget {
  final String imagePath;
  final double? radius;
  const CustomCircularImageCard({
    Key? key,
    required this.imagePath,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(),
      elevation: 5,
      child: CircleAvatar(
        radius: radius ?? 30.w,
        backgroundImage: Image.asset(imagePath).image,
      ),
    );
  }
}