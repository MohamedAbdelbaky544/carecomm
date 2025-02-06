import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double width;
  const Loader({super.key, this.width = 4.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: width,
      ),
    );
  }
}
