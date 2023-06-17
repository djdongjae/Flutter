import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'contact.dart';
import 'main.dart';

class ContactDetailApp extends StatefulWidget {
  final Future<Database> db;
  ContactDetailApp(this.db);

  @override
  State<StatefulWidget> createState() => _ContactDetailApp();

}

class _ContactDetailApp extends State<ContactDetailApp> {

  TextEditingController? addressController;
  TextEditingController? phoneNumberController;

  @override
  void initState() {
    super.initState();
    addressController = new TextEditingController();
    phoneNumberController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactDetail in Final Exam'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }

}