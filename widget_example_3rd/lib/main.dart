import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp()
    );
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  String? sum = '';
  TextEditingController v1 = TextEditingController();
  TextEditingController v2 = TextEditingController();
  List _bL = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dpm = new List.empty(growable: true);
  String? _bt;

  @override
  void initState() {
    super.initState();
    for(var item in _bL) {
      _dpm.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _bt = _dpm[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('flutter'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number, controller: v1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number, controller: v2,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add), Text(_bt!)
                    ],
                  ), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {
                    setState(() {
                      var v1Int = double.parse(v1.value.text);
                      var v2Int = double.parse(v2.value.text);
                      var result;
                      if(_bt == '더하기') {
                        result = v1Int + v2Int;
                      } else if(_bt == '빼기') {
                        result = v1Int - v2Int;
                      } else if(_bt == '곱하기') {
                        result = v1Int * v2Int;
                      } else {
                        result = v1Int / v2Int;
                      }
                      sum = '$result';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('결과: $sum', style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton(
                  items: _dpm,
                  onChanged: (String? value) {
                    setState(() {
                      _bt = value;
                    });
                  }, value: _bt,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
