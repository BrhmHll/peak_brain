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
      height: size.height - 95,
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
              width: size.width * 0.135),
        ));
  }

  Align buildBottomTodo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
              left: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(
                  hintText: 'Add a new todo item', border: InputBorder.none),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 20,
            right: 20,
          ),
          child: ElevatedButton(
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            onPressed: () {
              _addToDoItem(_todoController.text);
            },
            style: ElevatedButton.styleFrom(
              primary: tdBlue,
              minimumSize: Size(60, 60),
              elevation: 10,
            ),
          ),
        ),
      ]),
    );
  }

  Expanded buildBodyTodo() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 50,
              bottom: 20,
            ),
            child: Text(
              'All ToDos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (ToDo todoo in _foundToDo.reversed)
            ToDoItem(
              todo: todoo,
              onToDoChanged: _handleToDoChange,
              onDeleteItem: _deleteToDoItem,
            ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  SizedBox buildTop() {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Image.asset("assets/images/peakbrain_logo_blue.png", height: 48),
          SizedBox(
            width: 5,
            height: 5,
          ),
          Text(
            "PeakBrain",
            style: TextStyle(
                color: gmPriColor,
                fontSize: 36,
                fontWeight: FontWeight.w900,
                letterSpacing: 2),
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

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/peakbrain.jpeg'),
          ),
        ),
      ]),
    );
  }
}
