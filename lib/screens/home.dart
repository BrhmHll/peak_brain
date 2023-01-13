import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  Size size = const Size(0, 0);

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: gmBGColor,
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Column(
            children: [
              // searchBox(),
              buildTop(),
              buildBody()
              // buildBody()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      height: size.height - 105,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: size.width * 0.3,
              childAspectRatio: 1,
              crossAxisSpacing: size.width * 0.1,
              mainAxisSpacing: 8),
          itemCount: 26,
          itemBuilder: (_, index) {
            return buildGameButton(index);
          }),
    );
  }

  Widget buildGameButton(int index) {
    var gameName = "game" + (index + 1).toString();
    var activGames = ["game18", "game1"];
    var btnActive = true;
    if (!activGames.contains(gameName)) {
      btnActive = false;
    }
    return Container(
        height: size.width * 0.20,
        width: size.width * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size.width * 0.2)),
            color: gmPriColor),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/' + gameName);
          },
          icon: Image.asset("assets/images/" + gameName + ".png",
              width: size.width * 0.15),
        ));
  }

  SizedBox buildTop() {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/peakbrain_logo_blue.png",
                height: 56),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "PeakBrain",
              style: TextStyle(
                  color: gmPriColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2),
            ),
          ),
          // Image.asset("assets/images/peakbrain_name_blue.png", height: 20),
          Expanded(
            child: Container(),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.settings),
            iconSize: 40,
            color: gmPriColor,
          )
        ],
      ),
    );
  }
}
