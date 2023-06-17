import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'contact.dart';

class ContactCreateApp extends StatefulWidget {
  final Future<Database> db;
  ContactCreateApp(this.db);

  @override
  State<StatefulWidget> createState() => _ContactCreateApp();

}

class _ContactCreateApp extends State<ContactCreateApp> {

  TextEditingController? nameController;
  TextEditingController? addressController;
  TextEditingController? phoneNumberController;

  @override
  void initState() {
    super.initState();
    nameController = new TextEditingController();
    addressController = new TextEditingController();
    phoneNumberController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactCreate in Final Exam'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: '이름'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: '주소'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: '전화번호'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Contact contact = Contact(
                    name: nameController!.value.text,
                    address: addressController!.value.text,
                    phoneNumber: phoneNumberController!.value.text
                  );
                  Navigator.of(context).pop(contact);
                }, child: Text('생성'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('취소'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}