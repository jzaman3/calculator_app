import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  //handling initial start up of calculator and user inputs
  String starting_zero = "0";
  String first_number = "";
  String sign = "";
  double num1 = 0;
  double num2 = 0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") { //clear implemented then reset everything to initial
        starting_zero = "0";
        first_number = "";
        sign = "";
        num1 = 0;
        num2 = 0;
        //
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        if (first_number.isNotEmpty) { //make sure first num is nto empty
          num1 = double.parse(first_number); //parse stores the num1 to first_number
          sign = buttonText; //sign is set
          first_number = ""; //reset first_number to store num2 later on
          starting_zero = num1.toString() + sign; //update the starting num which was 0 to the new num1 and arithmetic sign
        }
      } else if (buttonText == "=") { //if both num1 and num2 are present then check sign and perform the arithmetic
        if (sign.isNotEmpty && first_number.isNotEmpty) {
          num2 = double.parse(first_number);
          switch (sign) {
            case "+":
              starting_zero = (num1 + num2).toString();
              break;
            case "-":
              starting_zero = (num1 - num2).toString();
              break;
            case "*":
              starting_zero = (num1 * num2).toString();
              break;
            case "/":
              if (num2 == 0) { //divide by zero error
                starting_zero = "Error";
              } else {
                starting_zero = (num1 / num2).toString();
              }
              break;
          }
          //reset everything
          first_number = starting_zero;
          sign = "";
          num1 = 0;
          num2 = 0;
        }
      } else { //appends user input for first_number as the user adds more numbers/signs to their input
        first_number += buttonText;
        starting_zero = first_number;
      }
    });
  }

