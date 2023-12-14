import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool valid;
  final String errorText;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({super.key,
    required this.errorText,
    required this.valid,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          errorText: valid ? null : errorText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid
                  ? const Color.fromRGBO(243, 244, 246, 1)
                  : Colors.red, // Adjust color as needed
              width: 3,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid
                  ? const Color.fromRGBO(231, 49, 157, 1)
                  : Colors.red, // Adjust color as needed
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid
                  ? const Color.fromRGBO(231, 49, 157, 1)
                  : Colors.red, // Adjust color as needed
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid
                  ? const Color.fromRGBO(231, 49, 157, 1)
                  : Colors.red, // Adjust color as needed
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid
                  ? const Color.fromRGBO(243, 244, 246, 1)
                  : Colors.red, // Adjust color as needed
              width: 3,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
        ),
      ),
    );
  }
}
