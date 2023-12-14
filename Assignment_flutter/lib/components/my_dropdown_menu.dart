import 'package:flutter/material.dart';

class MyDropDownMenu extends StatelessWidget {
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String hintText;

  const MyDropDownMenu({
    super.key,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    String? selectedOption;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        onChanged: (String? newValue) {
          selectedOption = newValue;
        },
        items: [
          DropdownMenuItem(value: option1, child: Text(option1)),
          DropdownMenuItem(value: option2, child: Text(option2)),
          DropdownMenuItem(value: option3, child: Text(option3)),
          DropdownMenuItem(value: option4, child: Text(option4)),
        ],

        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color.fromRGBO(243, 244, 246, 1)),
          ),
        ),
      ),
    );
  }
}

