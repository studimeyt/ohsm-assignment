import 'package:flutter/material.dart';

class MyTextFieldHeading extends StatelessWidget {
  final String heading;

  const MyTextFieldHeading({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            heading,
            style: const TextStyle(
              color: Color.fromRGBO(55, 65, 81, 1),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
