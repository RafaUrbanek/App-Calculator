import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final String _clear = 'Clear';
  Color color = Colors.white;
  String _expression = '';
  String _result = '';

  void _pressButton(String value) {
    setState(() {
      if (value == _clear) {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        _calculateResult();
      } else {
        _expression += value;
      }
    });
  }

  void _calculateResult() {
    try {
      _result = _evaluateExpression(_expression).toString();
    } catch (e) {
      _result = 'Invalid expression';
    }
  }

  double _evaluateExpression(String expression) {
    expression = expression.replaceAll('x', '*');
    expression = expression.replaceAll('÷', '/');
    ExpressionEvaluator valuer = const ExpressionEvaluator();
    double result = valuer.eval(Expression.parse(expression), {});
    return result;
  }

  Widget _button(String value) {
    if (value == _clear) {
      color = Colors.black;
    } else {
      color = Colors.teal;
    }
    return TextButton(
      child: Text(
        value,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold,color: color),
      ),
      onPressed: () => _pressButton(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(color: Colors.black),
              Text(_expression, style: const TextStyle(fontSize: 24)),
              //const Divider(color: Colors.teal),
              Text(_result, style: const TextStyle(fontSize: 24)),
              const Divider(color: Colors.black),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1.90,
            children: [
              _button('7'),
              _button('8'),
              _button('9'),
              _button('÷'),
              _button('4'),
              _button('5'),
              _button('6'),
              _button('x'),
              _button('1'),
              _button('2'),
              _button('3'),
              _button('-'),
              _button('0'),
              _button('.'),
              _button('='),
              _button('+'),
            ],
          ),
        ),
        Expanded(
          child: _button(_clear),
        ),
      ],
    );
  }
}
