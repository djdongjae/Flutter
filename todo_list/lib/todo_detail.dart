import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget {
  const TodoDetail({super.key, required this.title});
  final String title;

  @override
  State<TodoDetail> createState() => _TodoDetail();
}

class _TodoDetail extends State<TodoDetail> {

  @override
  Widget build(BuildContext context) {
    String todo = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("hello"),
            ElevatedButton(
              child: Text('확인'),
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