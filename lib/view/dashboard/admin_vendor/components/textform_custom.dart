import 'package:flutter/material.dart';
import 'package:zenify_admin_panel/main.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextForm(
      {super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: 1.0,
            color: MyAppColors.primaryred, // Customize border color as needed
          ),
        ),
        width: MediaQuery.of(context).size.width / 5,
        child: TextFormField(
          style: const TextStyle(),
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
