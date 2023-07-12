import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  // 버튼 텍스트 배열
  final List<String> buttons = [
    'C',
    '(',
    ')',
    '÷',
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

  // 계산 식
  String statement = "";
  // 계산 결과
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

  // 맨 위에 계산 결과를 보여주는 뷰
  Widget _resultView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            statement,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        const Divider(thickness: 1, height: 1, color: Colors.black),
        Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.centerRight,
          child: Text(result,
              style:
                  const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        ),
        const Divider(thickness: 1, height: 1, color: Colors.black),
      ],
    );
  }

  // 버튼을 그리드 형식으로 뿌려주는 함수
  Widget _buttons() {
    return GridView.builder(
      // 칸
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      // 값
      itemBuilder: (BuildContext context, int index) {
        return _myButton(buttons[index]);
      },
      itemCount: buttons.length,
    );
  }

  // 버튼 하나를 꾸며주는 함수
  Widget _myButton(String text) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            clickButton(text);
          });
        },
        color: _getColor(text),
        textColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 버튼의 색을 정하는 함수
  _getColor(String text) {
    if (text == '=' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == '÷') {
      return Colors.orangeAccent;
    }

    if (text == 'C' || text == 'AC') {
      return Colors.red;
    }

    if (text == '(' || text == ')' || text == '.') {
      return Colors.blueGrey;
    }

    return Colors.blueAccent;
  }

  // 버튼 반응
  clickButton(String text) {
    if (text == 'AC') {
      result = "0";
      return;
    }

    if (text == 'C') {
      statement = statement.substring(0, statement.length - 1);
      return;
    }

    if (text == '=') {
      result = calculate();
      return;
    }

    statement = statement + text;
  }

  // 계산
  calculate() {
    try {
      // statement 에 저장된 수식을 가져와서
      // math expressions 의 Parser() 함수로 분석한다.
      var exp = Parser().parse(statement);

      // 정답은 math expressions 의 evaluate 함수를 사용해서
      // 에러가 없을 경우 수식을 계산해서 문자열 형태로 출력
      var ans = exp.evaluate(EvaluationType.REAL, ContextModel());
      statement = "";
      return ans.toString();
    } catch (e) {
      // 잘못된 수식일 경우 '잘못된 수식' 출력
      return '잘못된 수식';
    }
  }
}
