import 'package:flutter/material.dart';

class LoadingSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;

  const LoadingSkeleton({
    super.key,
    this.height,
    this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.13),
          borderRadius: BorderRadius.circular(radius)),
    );
  }
}
