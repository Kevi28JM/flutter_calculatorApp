import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/colors.dart';
import 'package:flutter_application_1/providor/cal_provider.dart';
import 'package:provider/provider.dart';

//--------------------------IM-2021-050
// A reusable widget representing a button used in the calculator
class Button1 extends StatelessWidget {
  // Constructor accepting the button label and text color.
  // Defaults the text color to white if not provided
  const Button1(
      {super.key, required this.label, this.textColor = Colors.white});

  final String label; // The text displayed on the button
  final Color textColor; // The color of the text

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Makes the button tappable
      onTap: () => Provider.of<CalculatorProvider>(context, listen: false)
          .setValue(label),
      child: Material(
        // Adds a slight shadow effect to the button
        elevation: 3,
        // The background color of the button, coming from a predefined color
        color: AppColors.secondary2Color,
        // Rounds the corners of the button
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          // Sets the circular shape of the button with a radius of 34
          radius: 34,
          // Background color of the circle avatar
          backgroundColor: AppColors.secondary2Color,
          // The text displayed inside the button
          child: Text(
            label, // Display the label passed to the button
            style: TextStyle(
                color: textColor, // The color of the text
                fontSize: 32,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
