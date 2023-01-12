import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peak_brain/constants/colors.dart';
import 'package:peak_brain/constants/styles.dart';
import 'package:peak_brain/model/question.dart';
import 'package:peak_brain/widgets/answer_buttons.dart';
import 'package:peak_brain/widgets/custom_answer_button.dart';
import 'package:peak_brain/widgets/page_template.dart';

class Game18 extends StatefulWidget {
  Game18({Key? key}) : super(key: key);

  @override
  State<Game18> createState() => _Game18State();
}

class _Game18State extends State<Game18> {
  Size size = const Size(0, 0);
  final int targetPoint = 10;
  var random = Random();
  List<int> playersIndex = [0, 0];
  List<int> playersPoint = [0, 0];
  List<List<Color>> buttonColors = [
    [gmPriColor, gmPriColor, gmPriColor, gmPriColor],
    [gmPriColor, gmPriColor, gmPriColor, gmPriColor]
  ];
  List<Question> questions = [];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    createQuestions();

    return PageTemplate(
        content: Column(
      children: [
        //Player1
        RotatedBox(
          quarterTurns: 90,
          child: buildPlayer(questions, 0),
        ),
        buildPlayer(questions, 1)
      ],
    ));
  }

  void createQuestions() {
    if (questions.isNotEmpty) {
      return;
    }
    for (var i = 0; i < 10; i++) {
      createQuestion();
    }
    setState(() {
      questions;
    });
  }

  createQuestion() {
    var val1 = random.nextInt(10);
    var val2 = random.nextInt(10) + 1;
    int result = 0;
    var operationKey = random.nextInt(4);
    var operationIcon = "";
    switch (operationKey) {
      case 0:
        result = val1 + val2;
        operationIcon = "+";
        break;
      case 1:
        result = val1 - val2;
        operationIcon = "-";
        break;
      case 2:
        result = val1 * val2;
        operationIcon = "*";
        break;
      case 3:
        var lval1 = val1 * val2;
        result = val1;
        val1 = lval1;
        operationIcon = "/";
        break;
    }
    operationIcon = " " + operationIcon + " ";
    questions.add(Question(
        questionText: val1.toInt().toString() +
            operationIcon +
            val2.toInt().toString() +
            " = ?",
        answers: createAnswers(result),
        correctAnswer: result.toInt().toString()));
    setState(() {
      questions;
    });
  }

  List<String> createAnswers(correctAnswer) {
    List<String> result = [correctAnswer.toInt().toString()];
    while (result.length != 4) {
      var wrongAnswer = (correctAnswer + random.nextInt(10)).toInt().toString();
      var isAdded = false;
      for (var item in result) {
        if (item == wrongAnswer) {
          isAdded = true;
        }
      }
      if (isAdded == false) {
        result.add(wrongAnswer);
      }
    }
    return result;
  }

  SizedBox buildPlayer(List<Question> questions, int player) {
    var questionIndex = playersIndex[player];
    var point = playersPoint[player];
    return SizedBox(
      height: size.height * 0.475,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              SizedBox(
                width: (size.width * ((point) / targetPoint)) * 0.95,
                height: size.height * 0.07,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: Text(point == 0 ? "" : (point).toString(),
                      style: answerTextStyle),
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: size.height * 0.128,
              child: Center(
                  child: Text(questions[questionIndex].questionText,
                      style: questionTextStyle)),
            ),
          ),
          Center(
              child: Container(
                  child: AnswerButtons(
            size: Size(size.width * 0.955, size.height * 0.25),
            buttonTexts: questions[questionIndex].answers,
            buttonPress: (buttonWidget) {
              onPressAnswer(buttonWidget, questionIndex, player);
            },
            buttonColors: buttonColors[player],
          ))),
        ],
      ),
    );
  }

  onPressAnswer(CustomAnswerButton buttonWidget, questionIndex, player) {
    if (buttonWidget.buttonText == questions[questionIndex].correctAnswer) {
      if (playersPoint[player] == targetPoint - 1) {
        setState(() {
          playersPoint[player] = targetPoint;
          buttonColors[player] = [
            gmPriColor,
            gmPriColor,
            gmPriColor,
            gmPriColor
          ];
        });
        win(player);
        return;
      }
      setState(() {
        playersPoint[player] += 1;
        playersIndex[player] += 1;
        buttonColors[player] = [gmPriColor, gmPriColor, gmPriColor, gmPriColor];
      });

      if (questions.length == (questionIndex + 1)) {
        createQuestion();
      }
    } else {
      if (playersPoint[player] != 0) {
        setState(() {
          playersPoint[player] -= 1;
          buttonColors[player][buttonWidget.index] = Colors.red;
        });
      }
    }
  }

  void win(int playerIndex) {
    print("WINNNNN!");
  }
}
