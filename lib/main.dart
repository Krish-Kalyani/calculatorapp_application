import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator App'),
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
  String _displayText = '0';
  String _operand1 = '';
  String _operand2 = '';
  String _operator = '';

  void _clear() {
    setState(() {
      _displayText = '0';
      _operand1 = '';
      _operand2 = '';
      _operator = '';
    });
  }

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _clear();
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (_operand1.isNotEmpty) {
          _operator = value;
        }
      } else if (value == '=') {
        if (_operand1.isNotEmpty &&
            _operator.isNotEmpty &&
            _operand2.isNotEmpty) {
          _calculateResult();
        }
      } else {
        if (_operator.isEmpty) {
          _operand1 += value;
          _displayText = _operand1;
        } else {
          _operand2 += value;
          _displayText = _operand2;
        }
      }
    });
  }

  void _calculateResult() {
    double num1 = double.tryParse(_operand1) ?? 0;
    double num2 = double.tryParse(_operand2) ?? 0;
    double result = 0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          _displayText = 'Error';
          return;
        } else {
          result = num1 / num2;
        }
        break;
    }
    if (result == result.toInt()) {
      _displayText = result.toInt().toString();
    } else {
      _displayText = result.toString();
    }

    _operand1 = '';
    _operand2 = '';
    _operator = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'Welcome to Calculator App',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action for the button
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
