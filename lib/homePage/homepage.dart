import 'package:calculator_flutter/homePage/buttons.dart';
import 'package:calculator_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var expression = '';
var result = '';
var ans = '';

final List<String> buttonLabels = [
  'C',
  'DEL',
  '%',
  '/',
  '9',
  '8',
  '7',
  'x',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  'ANS',
  '=',
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Expressions
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 30.0, right: 10.0),
                  child: Text(
                    expression,
                    style: kExpressionStyle,
                  ),
                ),
                // Results
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    result,
                    style: kOutputStyle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttonLabels.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 0) {
                  return MyButton(
                      whenPressed: () {
                        setState(() {
                          expression = '';
                          result = '';
                        });
                      },
                      label: buttonLabels[index],
                      colour: Colors.green.shade800,
                      labelColor: isOperator(buttonLabels[index])
                          ? Colors.green.shade800
                          : kTextColor);
                }
                // Delete Button
                else if (index == 1) {
                  return MyButton(
                      whenPressed: () {
                        setState(() {
                          expression =
                              expression.substring(0, expression.length - 1);
                        });
                      },
                      label: buttonLabels[index],
                      colour: Colors.red.shade800,
                      labelColor: isOperator(buttonLabels[index])
                          ? Colors.green.shade800
                          : kTextColor);
                }
                // Equal Button
                else if (index == buttonLabels.length - 1) {
                  return MyButton(
                    whenPressed: () {
                      setState(() {
                        equalPressed();
                        ans = result;
                      });
                    },
                    label: buttonLabels[index],
                    colour: kButtonColor,
                    labelColor: isOperator(buttonLabels[index])
                        ? Colors.green.shade800
                        : kTextColor,
                  );
                }
                // ANS Button
                else if (index == 18) {
                  return MyButton(
                    whenPressed: () {
                      setState(() {
                        ans += expression;
                      });
                    },
                    label: buttonLabels[index],
                    colour: kButtonColor,
                    labelColor: isOperator(buttonLabels[index])
                        ? Colors.green.shade800
                        : kTextColor,
                  );
                }
                // All other Buttons
                else {
                  return MyButton(
                      whenPressed: () {
                        setState(() {
                          expression += buttonLabels[index];
                        });
                      },
                      label: buttonLabels[index],
                      colour: kButtonColor,
                      labelColor: isOperator(buttonLabels[index])
                          ? Colors.green.shade800
                          : kTextColor);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

bool isOperator(String x) {
  if (x == '%' || x == 'x' || x == '+' || x == '-' || x == '/' || x == '=') {
    return true;
  } else {
    return false;
  }
}

void equalPressed() {
  String finalQuestion = expression;
  finalQuestion = finalQuestion.replaceAll('x', '*');

  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);

  result = eval.toString();
}
