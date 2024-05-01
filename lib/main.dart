import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(75, 158, 158, 158),
        elevation: 5,
        title: Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: vis,
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.grey, fontSize: 30),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                answer,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            Row(
              children: [
                myButton(value: 'C', color: Colors.orangeAccent),
                myButton(value: '%', color: Colors.orangeAccent),
                myButton(value: '<', color: Colors.orangeAccent),
                myButton(value: '/', color: Colors.orangeAccent)
              ],
            ),
            Row(
              children: [
                myButton(value: '7'),
                myButton(value: '8'),
                myButton(value: '9'),
                myButton(value: 'x', color: Colors.orangeAccent)
              ],
            ),
            Row(
              children: [
                myButton(value: '4'),
                myButton(value: '5'),
                myButton(value: '6'),
                myButton(value: '-', color: Colors.orangeAccent)
              ],
            ),
            Row(
              children: [
                myButton(value: '1'),
                myButton(value: '2'),
                myButton(value: '3'),
                myButton(value: '+', color: Colors.orangeAccent)
              ],
            ),
            Row(
              children: [
                myButton(value: '00'),
                myButton(value: '0'),
                myButton(value: '.'),
                myButton(value: '=', color: Colors.orangeAccent)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myButton({required String value, color = Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: ElevatedButton(
          child: Text(
            value,
            style: TextStyle(
                color: color, fontSize: 28, fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(75, 158, 158, 158),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          onPressed: () => calculate(value),
        ),
      ),
    );
  }

  String result = "", operand = "", text = "", answer = "0";
  double first = 0, second = 0;
  bool vis = true;
  void calculate(String value) {
    vis = true;
    if (value == '+' ||
        value == '-' ||
        value == 'x' ||
        value == '/' ||
        value == '%') {
      first = double.parse(text);
      text = text + value;
      operand = value;
      result = "";
    } else if (value == "=") {
      second = double.parse(result);
      if (operand == "+") {
        answer = (first + second).toStringAsFixed(2);
        if (answer.endsWith('00')) answer = (first + second).toStringAsFixed(0);
      } else if (operand == "-") {
        answer = (first - second).toStringAsFixed(2);
        if (answer.endsWith('00')) answer = (first - second).toStringAsFixed(0);
      } else if (operand == "x") {
        answer = (first * second).toStringAsFixed(2);
        if (answer.endsWith('00')) answer = (first * second).toStringAsFixed(0);
      } else if (operand == "/") {
        answer = (first / second).toStringAsFixed(2);
        if (answer.endsWith('00')) answer = (first / second).toStringAsFixed(0);
      } else if (operand == "%") {
        answer = (first % second).toStringAsFixed(2);
        if (answer.endsWith('00')) answer = (first % second).toStringAsFixed(0);
      }
      text = answer;
      vis = false;
    } else if (value == "C") {
      first = 0;
      second = 0;
      result = "";
      text = "";
      answer = "0";
      operand = "";
    } else if (value == "<") {
      text = text.substring(0, text.length - 1);
      if (result.length > 1) {
        result = result.substring(0, result.length - 1);
      } else {
        result = result.substring(0, result.length);
      }
    } else {
      text = text + value;
      result = result + value;
    }
    setState(() {});
  }
}
