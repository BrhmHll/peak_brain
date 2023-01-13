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
    CustomAnswerButton.defaultButtonColors,
    CustomAnswerButton.defaultButtonColors
  ];
  int winnerPlayer = -1;
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
    for (var i = 0; i < targetPoint; i++) {
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

  List<String> createAnswers(int correctAnswer) {
    List<String> result = [];

    while (result.length != 3) {
      var wrongAnswer =
          (correctAnswer + random.nextInt(21) - 10).toInt().toString();
      var isAdded = false;
      for (var item in result) {
        if (item == wrongAnswer) {
          isAdded = true;
        }
      }
      if (isAdded == false && wrongAnswer != correctAnswer.toString()) {
        result.add(wrongAnswer);
      }
    }
    var correctAnswerIndex = random.nextInt(3);
    result.insert(correctAnswerIndex, correctAnswer.toString());
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
                  child: Text(point == 0 ? "" : " " + (point).toString(),
                      style: answerTextStyle),
                ),
              ),
            ],
          ),
          Visibility(
            visible: winnerPlayer == -1,
            child: Center(
              child: SizedBox(
                height: size.height * 0.128,
                child: Center(
                    child: Text(questions[questionIndex].questionText,
                        style: questionTextStyle)),
              ),
            ),
          ),
          Visibility(
            visible: winnerPlayer == -1,
            child: Center(
                child: Container(
                    child: AnswerButtons(
              size: Size(size.width * 0.955, size.height * 0.25),
              buttonTexts: questions[questionIndex].answers,
              buttonPress: (buttonWidget) {
                onPressAnswer(buttonWidget, questionIndex, player);
              },
              buttonColors: buttonColors[player],
            ))),
          ),
          Visibility(
              visible: winnerPlayer == player,
              child: Center(
                child: Container(
                    height: size.height * 0.25,
                    child: Image.asset(
                      "assets/images/cup.png",
                      width: size.width * 0.2,
                    )),
              )),
          Visibility(
              visible: winnerPlayer == player,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: size.height * 0.1,
                      child: IconButton(
                        onPressed: () {
                          restartGame();
                        },
                        icon: Image.asset(
                          "assets/images/restart.png",
                          width: size.width * 0.15,
                        ),
                        iconSize: size.width * 0.15,
                      )),
                ),
              )),
        ],
      ),
    );
  }

  onPressAnswer(CustomAnswerButton buttonWidget, questionIndex, player) {
    if (buttonWidget.buttonText == questions[questionIndex].correctAnswer) {
      if (playersPoint[player] == targetPoint - 1) {
        setState(() {
          playersPoint[player] = targetPoint;
          buttonColors[player] = CustomAnswerButton.defaultButtonColors;
          ;
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
        });
      }
      setState(() {
        buttonColors[player][buttonWidget.index] = Colors.red;
      });
    }
  }

  void win(int playerIndex) {
    print("WINNNNN!");
    setState(() {
      winnerPlayer = playerIndex;
    });
  }

  void restartGame() {
    playersIndex = [0, 0];
    playersPoint = [0, 0];
    buttonColors = [
      [gmPriColor, gmPriColor, gmPriColor, gmPriColor],
      [gmPriColor, gmPriColor, gmPriColor, gmPriColor]
    ];
    winnerPlayer = -1;
    questions = [];
    createQuestions();
  }
}
