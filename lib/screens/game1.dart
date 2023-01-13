import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peak_brain/constants/colors.dart';
import 'package:peak_brain/constants/styles.dart';
import 'package:peak_brain/widgets/answer_buttons.dart';
import 'package:peak_brain/widgets/custom_answer_button.dart';
import 'package:peak_brain/widgets/page_template.dart';

class Game1 extends StatefulWidget {
  Game1({Key? key}) : super(key: key);

  @override
  State<Game1> createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  var size = const Size(0, 0);
  int playerPoint = 0;
  int answerTime = 10;
  var questionText = "";
  var correctAnswer = "";
  List<String> answers = [];
  var random = Random();
  Timer timer = Timer(Duration.zero, () => {});
  bool timerDefined = false;
  List<Color> buttonColors = CustomAnswerButton.defaultButtonColors;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (!timerDefined) {
      createQuestion();
      timer = Timer.periodic(const Duration(seconds: 1), (ltimer) {
        timerFunc(ltimer);
      });
      timerDefined = true;
    }

    return PageTemplate(
        content: Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/timer_blue.png",
                  width: size.width * 0.1,
                ),
              ),
              Text(
                answerTime.toString(),
                style: questionTextStyle,
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/cup.png",
                  width: size.width * 0.1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  playerPoint.toString(),
                  style: questionTextStyle,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.58,
          child: Center(
            child: SizedBox(
              height: size.height * 0.128,
              child:
                  Center(child: Text(questionText, style: questionTextStyle)),
            ),
          ),
        ),
        AnswerButtons(
            size: Size(size.width * 0.955, size.height * 0.25),
            buttonTexts: answers,
            buttonPress: ((widget) {
              onPressAnswer(widget);
            }),
            buttonColors: buttonColors)
      ],
    ));
  }

  timerFunc(p_timer) {
    if (answerTime == 0) {
      endGame();
    } else {
      setState(() {
        answerTime -= 1;
      });
    }
  }

  onPressAnswer(CustomAnswerButton buttonWidget) {
    if (buttonWidget.buttonText == correctAnswer) {
      setState(() {
        playerPoint += 10;
      });
      createQuestion();
    } else {
      endGame();
    }
  }

  endGame() {
    print("End Game");
    timer.cancel();
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

    setState(() {
      operationIcon = " " + operationIcon + " ";
      questionText = val1.toInt().toString() +
          operationIcon +
          val2.toInt().toString() +
          " = ?";
      answers = createAnswers(result);
      correctAnswer = result.toString();
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
}
