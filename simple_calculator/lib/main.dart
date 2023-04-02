import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String sum = ' ';
  TextEditingController _tecStrNum1 = TextEditingController();
  TextEditingController _tecStrNum2 = TextEditingController();

  List _strButtonList = ["더하기", "빼기", "곱하기", "나누기"];
  List<DropdownMenuItem<String>> _dropdownMenuItemList = List.empty(growable: true);
  String? _strCurrentButton;

  @override
  void initState() {
    super.initState();
      for(var str in _strButtonList) {
        _dropdownMenuItemList.add(DropdownMenuItem(child: Text(str), value: str),);
      }
    _strCurrentButton = _dropdownMenuItemList[0].value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text("결과: ${ sum }", style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right:15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _tecStrNum1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right:15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _tecStrNum2,

                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                    child: Text(_strCurrentButton!),
                    onPressed: (){
                      double result = 0.0;
                      double operand1 = double.parse(_tecStrNum1.value.text);
                      double operand2 = double.parse(_tecStrNum2.value.text);
                      switch(_strCurrentButton) {
                        case "더하기":
                          result = operand1 + operand2;
                          break;
                        case "빼기":
                          result = operand1 - operand2;
                          break;
                        case "곱하기":
                          result = operand1 * operand2;
                          break;
                        case "나누기":
                          result = operand1 / operand2;
                          break;
                      }
                      setState(() {
                        String strResult = result.toString();
                        sum = '$strResult';
                      });
                      },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton(
                  items: _dropdownMenuItemList,
                  onChanged: (String? value) {
                    setState(() {
                      _strCurrentButton = value;
                    });
                  },
                  value: _strCurrentButton,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
