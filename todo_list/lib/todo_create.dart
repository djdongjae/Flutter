import 'package:flutter/material.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key, required this.title});

  final String title;

  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}