import 'package:flutter/material.dart';
import 'package:peak_brain/widgets/custom_answer_button.dart';

class AnswerButtons extends StatefulWidget {
  AnswerButtons(
      {Key? key,
      required this.size,
      required this.buttonTexts,
      required this.buttonPress,
      required this.buttonColors})
      : super(key: key);

  final Size size;
  final List<String> buttonTexts;
  List<Color> buttonColors;
  final Null Function(CustomAnswerButton widget) buttonPress;

  @override
  State<AnswerButtons> createState() => _AnswerButtonsState();
}

class _AnswerButtonsState extends State<AnswerButtons> {
  @override
  Widget build(BuildContext context) {
    var buttonSize = Size(widget.size.width * 0.5, widget.size.height * 0.5);
    return Column(
      children: [
        Row(
          children: [
            CustomAnswerButton(
              size: buttonSize,
              buttonText: widget.buttonTexts[0],
              buttonPress: widget.buttonPress,
              bgColor: widget.buttonColors[0],
              index: 0,
            ),
            CustomAnswerButton(
                size: buttonSize,
                buttonText: widget.buttonTexts[1],
                buttonPress: widget.buttonPress,
                bgColor: widget.buttonColors[1],
                index: 1),
          ],
        ),
        Row(
          children: [
            CustomAnswerButton(
                size: buttonSize,
                buttonText: widget.buttonTexts[2],
                buttonPress: widget.buttonPress,
                bgColor: widget.buttonColors[2],
                index: 2),
            CustomAnswerButton(
                size: buttonSize,
                buttonText: widget.buttonTexts[3],
                buttonPress: widget.buttonPress,
                bgColor: widget.buttonColors[3],
                index: 3),
          ],
        )
      ],
    );
  }
}
