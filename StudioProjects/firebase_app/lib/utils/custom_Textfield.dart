import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.hintColor = Colors.white, // Default hint color is white
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final Color hintColor; // New parameter to accept hint text color

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white), // Set text color to white
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: hintColor), // Set hint text color
        ),
      ),
    );
  }
}
