import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

// Define the CalculatorApp class
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Calculator(),
    );
  }
}

// Define the Calculator StatefulWidget
class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

// The existing _CalculatorState class
class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _result = "0";
  String _operation = "";
  double num1 = 0.0;
  double num2 = 0.0;

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _result = "0";
      num1 = 0.0;
      num2 = 0.0;
      _operation = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "*") {
      num1 = double.tryParse(_output) ?? 0.0;
      _operation = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.tryParse(_output) ?? 0.0;
      switch (_operation) {
        case "+":
          _result = (num1 + num2).toString();
          break;
        case "-":
          _result = (num1 - num2).toString();
          break;
        case "*":
          _result = (num1 * num2).toString();
          break;
        case "/":
          _result = num2 != 0 ? (num1 / num2).toString() : "Error";
          break;
        default:
          break;
      }
      _output = _result;
      _operation = "";
      num1 = 0.0;
      num2 = 0.0;
    } else {
      // Check if _output is "0" and the button pressed is a number
      if (_output == "0" && buttonText != ".") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }
    setState(() {
      _output = _output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(child: Divider()),
          ..._buildCalculatorButtons(),
        ],
      ),
    );
  }

  List<Widget> _buildCalculatorButtons() {
    // This function builds buttons in a more scalable way
    List<List<String>> buttons = [
      ["7", "8", "9", "/"],
      ["4", "5", "6", "*"],
      ["1", "2", "3", "-"],
      [".", "0", "00", "+"],
      ["C", "="]
    ];
    return buttons.map((List<String> row) {
      return Row(
        children: row.map((String buttonText) {
          return buildButton(buttonText);
        }).toList(),
      );
    }).toList();
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}