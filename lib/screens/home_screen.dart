import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/colors.dart';
import 'package:flutter_application_1/providor/cal_provider.dart';
import 'package:flutter_application_1/screens/widgets_data.dart';
import 'package:flutter_application_1/widgets/button1.dart';
import 'package:flutter_application_1/widgets/textField.dart';
import 'package:provider/provider.dart';

import '../widgets/cal_button.dart';

//--------------------------IM-2021-050-----------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Constructor for the HomeScreen widget

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context)
        .height; // Get the screen height for layout adjustments
    final Padding = EdgeInsets.symmetric(horizontal: 25, vertical: 40);
    final decoration = const BoxDecoration(
        color: AppColors.thirdColor,
        borderRadius: BorderRadiusDirectional.all(Radius.circular(30)));

    return Consumer<CalculatorProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Calculator"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            CustomTextField(
              controller: provider.compController,
            ),
            Spacer(),
            Container(
              height: screenHeight * 0.69,
              width: double.infinity,
              padding: Padding,
              decoration: decoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => buttonList[index]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(4, (index) => buttonList[index + 4]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(4, (index) => buttonList[index + 8]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(4, (index) => buttonList[index + 12]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(4, (index) => buttonList[index + 16]),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              2, (index) => buttonList[index + 20]),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      calculatorButton()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
