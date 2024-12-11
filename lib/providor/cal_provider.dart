import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

//--------------------------IM-2021-050
// A provider class to handle calculator logic and notify listeners (UI) when changes occur.
class CalculatorProvider extends ChangeNotifier {
  // A controller to manage the input and output text in the calculator's TextField.
  final TextEditingController compController = TextEditingController();
  int openBracketCount = 0; // Tracks unmatched '('

// Function to update the value displayed in the TextField based on button pressed.
  setValue(String value) {
    // Get the current text from the TextField
    String str = compController.text;

    // Prevent further input except "C" if the current text is "Error" or invalid
    if (str == "Error") {
      if (value != "C") {
        return; // Prevent any input except clearing
      }
    }

// Perform different actions based on the button pressed

    switch (value) {
      case "C": // Clear the entire input
        compController.clear();
        openBracketCount = 0; // Reset bracket count
        break;

      case "D": // Delete the last character from the input
        if (str.isNotEmpty) {
          if (str.endsWith("(")) openBracketCount--;
          if (str.endsWith(")")) openBracketCount++;
          compController.text = str.substring(0, str.length - 1);
        }
        break;

      case "x": // Replace 'x' with '*' for multiplication
        if (str.isNotEmpty) {
          if (RegExp(r'[+\-*/]$').hasMatch(str)) {
            if (str[str.length - 1] != '*') {
              // Replace the last operator with '*'
              compController.text = str.substring(0, str.length - 1) + '*';
            }
          } else {
            // Append '*' if the last character is not an operator
            compController.text += '*';
          }
        }
        break;

      case "÷": // Replace '÷' with '/' for division
        if (str.isNotEmpty) {
          if (RegExp(r'[+\-*/]$').hasMatch(str)) {
            if (str[str.length - 1] != '/') {
              // Replace the last operator with '/'
              compController.text = str.substring(0, str.length - 1) + '/';
            }
          } else {
            // Append '/' if the last character is not an operator
            compController.text += '/';
          }
        }
        break;

      case "+": // Addition
      case "-": // Subtraction
      case "*": // Multiplication
      case "/": // Division
        if (str.isNotEmpty) {
          // Check if the last character is an operator
          if (RegExp(r'[+\-*/]$').hasMatch(str)) {
            if (str[str.length - 1] != value) {
              // Replace the last operator with the new one if it differs
              compController.text = str.substring(0, str.length - 1) + value;
            }
          } else if (RegExp(r'[a-zA-Z0-9)]$').hasMatch(str)) {
            // Append the operator if the last character is not an operator
            compController.text += value;
          }
        }
        break;

      case "√": // Append '√' for square root operation
        if (str.isEmpty || str.endsWith(" ")) {
          compController.text += "sqrt("; // Start a square root operation
        } else {
          // Automatically insert multiplication if there's a number before '√'
          compController.text += "*sqrt(";
        }
        break;

      case "%": // Handle modulo
        if (str.isNotEmpty && !str.endsWith(" ")) {
          compController.text += "%";
        }
        break;

      case "(": // Handle opening bracket
        if (str.isEmpty ||
            str.endsWith(" ") ||
            RegExp(r'[+\-*/(]').hasMatch(str[str.length - 1])) {
          compController.text += "(";
          openBracketCount++;
        }
        break;

      case ")": // Handle closing bracket
        if (openBracketCount > 0 &&
            (RegExp(r'\d$').hasMatch(str) || str.endsWith(")"))) {
          compController.text += ")";
          openBracketCount--;
        }
        break;

      case "+/-": // Toggle the sign of the last number
        if (str.isNotEmpty) {
          // Find the last number in the string
          final regex = RegExp(r'(-?\d+\.?\d*)$');
          final match = regex.firstMatch(str);
          if (match != null) {
            // Extract the matched number and toggle its sign
            String lastNumber = match.group(0)!;
            if (lastNumber.startsWith('-')) {
              // If the number is negative, remove the '-' sign
              compController.text =
                  str.replaceFirst(lastNumber, lastNumber.substring(1));
            } else {
              // If the number is positive, add a '-' sign
              compController.text =
                  str.replaceFirst(lastNumber, '-$lastNumber');
            }
          }
        }
        break;

      case "=": // Calculate the result when '=' is pressed
        compute();
        break;

      case ".": // Handle decimal point input
        if (compController.text.isEmpty ||
            compController.text.endsWith(" ") ||
            compController.text.endsWith(".") ||
            compController.text.split(RegExp(r'[+\-*/]')).last.contains(".")) {
          // If input is empty, already has a decimal, or after an operator, do nothing
          break;
        }
        compController.text += "."; // Append the decimal
        break;

      default: // Append any other button value to the input
        if (RegExp(r'\d').hasMatch(value)) {
          // Check if the input is a digit
          final parts = str
              .split(RegExp(r'[+\-*/()]')); // Split by operators or parentheses
          final lastPart =
              parts.isNotEmpty ? parts.last : ""; // Get the last number part
          if (lastPart.length < 15) {
            // Allow up to 15 digits for the last number
            compController.text += value;
          }
        } else {
          compController.text +=
              value; // Append operators or other non-digit values
        }
        break;
    }

    // Set the cursor position to the end of the text after updating
    compController.selection = TextSelection.fromPosition(
        TextPosition(offset: compController.text.length));
  }

  // Function to compute the result of the mathematical expression
  compute() {
    try {
      String text = compController.text; // Get the current input text

      // Replace '√' with `sqrt(` if it hasn't been closed
      if (text.contains("sqrt(") && !text.contains(")")) {
        text += ")"; // Automatically close the parenthesis
        openBracketCount--;
      }

      // Check for division by zero
      if (text.contains("/0")) {
        compController.text = "Error";
        return;
      }

      // Handle percentage: Replace `number%` with `(number / 100)`
      final regexPercent = RegExp(r'(\d+)%');
      text = text.replaceAllMapped(
          regexPercent, (match) => '(${match.group(1)}/100)');

      // Ensure all open brackets are closed
      while (openBracketCount > 0) {
        text += ")";
        openBracketCount--;
      }

      // Evaluate the expression
      double result = (text.interpret() as num).toDouble();

      // Format the result based on whether it's a whole number or not
      String resultStr;
      if (result == result.toInt()) {
        // If the result is a whole number, display it as a decimal with one zero
        resultStr = result.toStringAsFixed(1);
      } else {
        // Otherwise, display up to 10 decimal places
        resultStr = result.toStringAsFixed(10);
      }

      compController.text = resultStr;
    } catch (e) {
      compController.text = "Error"; // Display error for invalid expressions
    }
  }

  @override
  void dispose() {
    super.dispose();
    compController
        .dispose(); // Dispose of the TextEditingController to free up resources
  }
}
