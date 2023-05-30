import 'package:flutter/material.dart';
import 'package:todo_list_sqllite/model/todo.dart';

class TodoCreate extends StatefulWidget {
  final String title;

  const TodoCreate({super.key, required this.title});

  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {
  TextEditingController _tecTitleController = TextEditingController();
  TextEditingController _tecContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _tecTitleController,
                  decoration: InputDecoration(
                    labelText: "제목",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _tecContentController,
                  decoration: InputDecoration(
                    labelText: "할 일",
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('저장'),
                onPressed: () {
                  Todo todo = Todo(
                      title: _tecTitleController.value.text,
                      content: _tecContentController.value.text,
                      hasFinished: 0);
                  Navigator.of(context).pop(todo);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
