import 'package:flutter/material.dart';

//--------------------------IM-2021-050-----------------------------------------

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              return FittedBox(
                fit: BoxFit.scaleDown, // Ensures all text fits within the width
                alignment: Alignment.centerRight,
                child: Text(
                  value.text.isNotEmpty ? value.text : '0', // Show '0' if empty
                  style: const TextStyle(
                    fontSize: 45, // Base font size
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
