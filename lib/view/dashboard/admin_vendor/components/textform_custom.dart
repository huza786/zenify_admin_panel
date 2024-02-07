import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextForm(
      {super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
