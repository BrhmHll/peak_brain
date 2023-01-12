import 'package:flutter/material.dart';
import 'package:peak_brain/constants/colors.dart';

class PageTemplate extends StatefulWidget {
  PageTemplate({
    Key? key,
    required this.content,
  }) : super(key: key);
  final Column content;

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  Size size = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: gmBGColor,
        body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: widget.content),
      ),
    );
  }
}
