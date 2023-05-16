import 'package:flutter/material.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key, required this.title});

  final String title;

  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {
  TextEditingController _texStrTodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _texStrTodo,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "할 일"),
            ),
            ElevatedButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop(_texStrTodo.value.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
