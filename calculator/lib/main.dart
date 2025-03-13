import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  String _inputText = "0";
  String userExpression = "";
  String operator = "0";
  double num1 = 0;
  double num2 = 0;
  void btnPressed(String value) {
    setState(() {
      if (value == "CLEAR") {
        _inputText = "0";
        userExpression = "";
        num1 = 0;
        num2 = 0;
      } else if (value == "+" || value == "-" || value == "/" || value == "x") {
        operator = value;
        num1 = double.parse(_inputText);
        userExpression = _inputText + operator;
        print(" $_inputText this is frist num");
        _inputText = "";
      } else if (value == "=") {
        num2 = double.parse(_inputText);

        String formattedNum1 =
            (num1 == num1.truncate())
                ? num1.toInt().toString()
                : num1.toString();
        String formattedNum2 =
            (num2 == num2.truncate())
                ? num2.toInt().toString()
                : num2.toString();
        userExpression = "$formattedNum1 $operator $formattedNum2 =";
        // userExpression = "$num1 $operator $num2 = ";
        if (operator == "+") {
          _inputText = (num1 + num2).toString();
        } else if (operator == "-") {
          _inputText = (num1 - num2).toString();
        } else if (operator == "x") {
          _inputText = (num1 * num2).toString();
        } else if (operator == "/") {
          _inputText = (num1 / num2).toString();
        }

        num1 = 0;
        num2 = 0;
        operator = "";
      } else {
        print(" this $value is pressed");
        userExpression += value;
        if (_inputText == '0') {
          _inputText = value;
        } else {
          _inputText += value;
        }
      }
      if (_inputText.isNotEmpty) {
        _inputText =
            double.tryParse(_inputText)?.toStringAsFixed(0) ?? _inputText;
      }
    });
  }

  Widget button(String value) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: EdgeInsets.all(1),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            onPressed: () {
              btnPressed(value);
            },
            child: Text(value),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(16),
            child: Text(userExpression, style: TextStyle(fontSize: 21)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(16),
            child: Text(_inputText, style: TextStyle(fontSize: 21)),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [button("7"), button("8"), button("9"), button("/")],
              ),
              Row(
                children: [button("4"), button("5"), button("6"), button("x")],
              ),
              Row(
                children: [button("1"), button("2"), button("3"), button("-")],
              ),
              Row(
                children: [button("."), button("0"), button("00"), button("+")],
              ),
              Row(children: [button("CLEAR"), button("=")]),
            ],
          ),
        ],
      ),
    );
  }
}
