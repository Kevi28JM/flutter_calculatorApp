import 'package:flutter/material.dart';
import 'package:flutter_application_1/providor/cal_provider.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/widgets/textField.dart';
import 'package:provider/provider.dart';

//--------------------------IM-2021-050
void main() {
  // The entry point of the Flutter application
  runApp(
      CalculatorApp()); // Runs the CalculatorApp widget as the root of the application
}

class CalculatorApp extends StatelessWidget {
  // The root widget of the calculator application
  const CalculatorApp({super.key}); // Constructor for the CalculatorApp widget

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provides the CalculatorProvider to all widgets in the widget tree
      create: (context) => CalculatorProvider(),
      child: MaterialApp(
        // Defines the main structure of the app
        theme: ThemeData.dark(), // Sets a dark theme for the app
        debugShowCheckedModeBanner:
            false, // Hides the "Debug" banner in the app
        home:
            HomeScreen(), // Sets the HomeScreen widget as the initial screen of the app
      ),
    );
  }
}
