import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 스티커 없애기
      title: '간단한 계산기',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<String> buttons = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '='
  ];

  // 현재 상황
  String statement = "";
  // 결과
  String result = "0";

  @override
  Widget build(BuildContext context) {
    // 앱 크기에 따라 조절해줌
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(flex: 2, child: _resultView()),
            Expanded(flex: 4, child: _buttons()),
          ],
        ),
      ),
    );
  }

  Widget _resultView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(statement),
        ),
        Container(
          child: Text(result),
        ),
      ],
    );
  }

  Widget _buttons() {
    return Container();
  }
}
