import 'package:flutter/material.dart';
import 'package:peak_brain/constants/colors.dart';
import 'package:peak_brain/constants/styles.dart';

class CustomAnswerButton extends StatefulWidget {
  CustomAnswerButton(
      {Key? key,
      required this.index,
      required this.size,
      required this.buttonText,
      required this.buttonPress,
      required this.bgColor})
      : super(key: key);

  final Size size;
  final int index;
  final String buttonText;
  final Null Function(CustomAnswerButton widget) buttonPress;
  Color bgColor;

  @override
  State<CustomAnswerButton> createState() => _CustomAnswerButtonState();
}

class _CustomAnswerButtonState extends State<CustomAnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.size.width * 0.01),
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        decoration: BoxDecoration(
            color: widget.bgColor, borderRadius: BorderRadius.circular(5)),
        child: GestureDetector(
          child: Container(
              width: widget.size.width,
              height: widget.size.height,
              child: Center(
                  child: Text(widget.buttonText, style: answerTextStyle))),
          onTap: () {
            widget.buttonPress(widget);
          },
        ),
      ),
    );
  }
}
