import 'package:flutter/material.dart';
import 'sub/firstPage.dart';
import 'sub/secondPage.dart';
import './animalItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'animal listview home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController? c;
  List<Animal> al = new List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animal List'),),
      body: TabBarView(
        children: <Widget>[
          FirstApp(list: al), SecondApp(list: al)
        ], controller: c,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue,),),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue,),),
        ], controller: c,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    c = TabController(length: 2, vsync: this);
    al.add(Animal(an:"벌", k:"곤충", ip: "repo/images/bee.png"));
    al.add(Animal(an:"고양이", k:"포유류", ip: "repo/images/cat.png"));
    al.add(Animal(an:"소", k:"포유류", ip: "repo/images/cow.png"));
    al.add(Animal(an:"개", k:"천사", ip: "repo/images/dog.png"));
    al.add(Animal(an:"여우", k:"포유류", ip: "repo/images/fox.png"));
    al.add(Animal(an:"원숭이", k:"영장류", ip: "repo/images/monkey.png"));
    al.add(Animal(an:"돼지", k:"음식", ip: "repo/images/pig.png"));
    al.add(Animal(an:"늑대", k:"포유류", ip: "repo/images/wolf.png"));
  }
}
