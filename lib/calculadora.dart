import 'package:calculadora/calcBotao.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String equation = "";
  String result = "0";
  String expression = "";
  bool shouldReplace =
      false; // Flag to determine if the result should replace the equation

  buttonPressed(String buttonText) {
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return splitDecimal[0].toString();
        }
      }
      return result.toString();
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        shouldReplace = false;
      } else if (buttonText == "⌫") {
        if (equation.length > 1) {
          equation = equation.substring(0, equation.length - 1);
        } else {
          equation = "0";
        }
        if (equation == "") {
          equation = "";  
        }
        shouldReplace = false;
      } else if (buttonText == "+/-") {
        if (equation != "0") {
          equation = equation[0] == '-' ? equation.substring(1) : '-$equation';
        }
        shouldReplace = false;
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
          equation = result; // Update the equation to show the result
          shouldReplace =
              true; // Indicate that the next input should replace the result
        } catch (e) {
          result = "Vish ferrou";
        }
      } else {
        {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(result,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 80)),
                      ),
                      SizedBox(width: 20)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(equation,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white38,
                            )),
                      ),
                      IconButton(
                        icon: const Icon(Icons.backspace_outlined,
                            color: Colors.orange, size: 30),
                        onPressed: () {
                          buttonPressed("⌫");
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.white24, () => buttonPressed('AC')),
                calcButton('%', Colors.white24, () => buttonPressed('%')),
                calcButton('÷', Colors.white24, () => buttonPressed('÷')),
                calcButton("x", Colors.white24, () => buttonPressed('x')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.white10, () => buttonPressed('7')),
                calcButton('8', Colors.white10, () => buttonPressed('8')),
                calcButton('9', Colors.white10, () => buttonPressed('9')),
                calcButton('-', Colors.white24, () => buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.white10, () => buttonPressed('4')),
                calcButton('5', Colors.white10, () => buttonPressed('5')),
                calcButton('6', Colors.white10, () => buttonPressed('6')),
                calcButton('+', Colors.white24, () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.white10, () => buttonPressed('1')),
                calcButton('2', Colors.white10, () => buttonPressed('2')),
                calcButton('3', Colors.white10, () => buttonPressed('3')),
                calcButton('+/-', Colors.white24, () => buttonPressed('+/-')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('.', Colors.white24, () => buttonPressed('.')),
                calcButton('0', Colors.white10, () => buttonPressed('0')),
                calcButton('=', Colors.orange, () => buttonPressed('=')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
