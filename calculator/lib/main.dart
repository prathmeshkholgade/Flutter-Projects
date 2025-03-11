import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String _operator = "";
  String expression = "";

  void buttonPressed(String buttonText) {
    setState(() {
      // if (buttonText == "1") {
      //   buttonText = "2";
      // }
      if (buttonText == "CLEAR") {
        output = "0";
        _output = "0";
        num1 = 0;
        num2 = 0;
        _operator = "";
        expression = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "x") {
        num1 = double.parse(output);
        _operator = buttonText;
        expression = "$output $_operator"; // Show operator immediately
        _output = "";
      } else if (buttonText == "=") {
        print(num1);
        num2 = double.parse(output);
        String formattedNum1 =
            (num1 == num1.truncate())
                ? num1.toInt().toString()
                : num1.toString();
        String formattedNum2 =
            (num2 == num2.truncate())
                ? num2.toInt().toString()
                : num2.toString();
        expression =
            "$formattedNum1 $_operator $formattedNum2 ="; // Update expression

        if (_operator == "+") {
          print("button is pressed");
          _output = (num1 + num2).toString();
        } else if (_operator == "-") {
          _output = (num1 - num2).toString();
        } else if (_operator == "x") {
          _output = (num1 * num2).toString();
        } else if (_operator == "/") {
          _output = (num1 / num2).toString();
        }

        num1 = 0;
        num2 = 0;
        _operator = "";
      } else {
        _output += buttonText;
        expression += buttonText; // Update expression in real-time
      }

      output = double.parse(_output).toStringAsFixed(0);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: SizedBox(
          height: 70.0,
          child: OutlinedButton(
            onPressed: () => buttonPressed(buttonText),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            child: Text(
              expression, // Updated expression
              style: const TextStyle(fontSize: 32, color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("x"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(children: [buildButton("CLEAR"), buildButton("=")]),
            ],
          ),
        ],
      ),
    );
  }
}
