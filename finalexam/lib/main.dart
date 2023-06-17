import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'contact.dart';
import 'contact_create.dart';
import 'contact_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Final Exam App 2023-01',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => ContactCreateApp(database),
        '/detail': (context) => ContactDetailApp(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'contact_database.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT, phoneNumber TEXT)");
    }, version: 1);
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  DatabaseApp(this.db);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Contact>>? contactList;

  @override
  void initState() {
    super.initState();
    contactList = getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Exam App 2023-01'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(itemBuilder: (context, index) {
                      Contact contact = (snapshot.data as List<Contact>)[index];
                      return ListTile(
                        title:
                            Text(contact.name!, style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                          child: Column(
                            children: <Widget>[
                              Text(contact.address!),
                              Text(contact.phoneNumber!),
                              Container(height: 1, color: Colors.blue)
                            ],
                          ),
                        ),
                        onTap: () async {
                          TextEditingController controller1 = new TextEditingController(text: contact.address);
                          TextEditingController controller2 = new TextEditingController(text: contact.phoneNumber);

                          Contact result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('${contact.id} : ${contact.name}'),
                                content: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          TextField(
                                            controller: controller1,
                                            decoration: InputDecoration(labelText: '주소'),
                                          ),
                                          TextField(
                                            controller: controller2,
                                            decoration: InputDecoration(labelText: '전화번호'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(contact);
                                    },child: Text('수정'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },child: Text('취소'),
                                  ),
                                ],
                              );
                            }
                          );
                          _updateContact(result);
                        },
                        onLongPress: () async {
                          Contact result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text('${contact.id} : ${contact.name}'),
                                  content: Text('연락처를 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(contact);
                                      },
                                      child: Text('삭제'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('취소'),
                                    ),
                                  ],
                                );
                              });
                          _deleteContact(result);
                        },
                      );
                    }, itemCount: (snapshot.data as List<Contact>).length);
                  } else {
                    return Text('No data');
                  }
              }
            }, future: contactList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final contact = await Navigator.of(context).pushNamed('/add');
          if (contact != null) {
            _insertContact(contact as Contact);
          }
        }, child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _insertContact(Contact contact) async {
    final Database database = await widget.db;
    await database.insert('contacts', contact.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      contactList = getContacts();
    });
  }

  Future<List<Contact>> getContacts() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('contacts');
    return List.generate(maps.length, (i){
      return Contact(
        name: maps[i]['name'].toString(),
        address: maps[i]['address'].toString(),
        phoneNumber: maps[i]['phoneNumber'].toString(),
        id: maps[i]['id']
      );
    });
  }

  void _updateContact(Contact contact) async {
    final Database database = await widget.db;
    await database.update(
      'contacts',
      contact.toMap(),
      where: 'id=?',
      whereArgs: [contact.id]
    );
    setState(() {
      contactList = getContacts();
    });
  }

  void _deleteContact(Contact contact) async {
    final Database database = await widget.db;
    await database.delete(
        'contacts',
        where: 'id=?',
        whereArgs: [contact.id]
    );
    setState(() {
      contactList = getContacts();
    });
  }

}
