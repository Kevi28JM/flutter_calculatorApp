import 'package:flutter/material.dart';
import 'package:flutter_application_1/providor/cal_provider.dart';
import 'package:provider/provider.dart';

//--------------------------IM-2021-050--------------------------------------------
class calculatorButton extends StatelessWidget {
  const calculatorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Provider.of<CalculatorProvider>(context, listen: false).setValue("="),
      child: Container(
        height: 70,
        width: 160,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(29, 132, 11, 0.973),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            "=",
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
