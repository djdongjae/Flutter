import 'package:flutter/cupertino.dart';
import '../animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CupertinoSecondPage();

  final List<Animal>? list;

  const CupertinoSecondPage({Key? key, required this.list}) : super(key: key);
}

class _CupertinoSecondPage extends State<CupertinoSecondPage> {
  TextEditingController? _tc;
  int _kc = 0;
  bool f = false;
  String? _ip;
  Map<int, Widget> sw = {
    0: SizedBox(
      child: Text('양서류', textAlign: TextAlign.center),
      width: 80,
    ),
    1: SizedBox(
      child: Text('포유류', textAlign: TextAlign.center),
      width: 80,
    ),
    2: SizedBox(
      child: Text('파충류', textAlign: TextAlign.center),
      width: 80,
    ),
  };

  @override
  void initState() {
    super.initState();
    _tc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('동물 추가'),
      ),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: _tc,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              CupertinoSegmentedControl(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                groupValue: _kc,
                children: sw,
                onValueChanged: (int value) {
                  setState(() {
                    _kc = value;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  Text('날개가 존재합니까?'),
                  CupertinoSwitch(
                    value: f,
                    onChanged: (value) {
                      setState(() {
                        f = value;
                      });
                    },
                  )
                ], mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                        child: Image.asset('repo/images/cow.png', width: 80),
                        onTap: () {
                          _ip = 'repo/images/cow.png';
                        }
                    ),
                    GestureDetector(
                        child: Image.asset('repo/images/pig.png', width: 80),
                        onTap: () {
                          _ip = 'repo/images/pig.png';
                        }
                    ),
                    GestureDetector(
                        child: Image.asset('repo/images/bee.png', width: 80),
                        onTap: () {
                          _ip = 'repo/images/bee.png';
                        }
                    ),
                    GestureDetector(
                        child: Image.asset('repo/images/cat.png', width: 80),
                        onTap: () {
                          _ip = 'repo/images/cat.png';
                        }
                    ),
                    GestureDetector(
                        child: Image.asset('repo/images/fox.png', width: 80),
                        onTap: () {
                          _ip = 'repo/images/fox.png';
                        }
                    ),
                    GestureDetector(
                        child: Image.asset('repo/images/monkey.png', width: 80),
                        onTap: () {
                          _ip = 'repo/images/monkey.png';
                        }
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                  child: Text('동물 추가하기'),
                  onPressed: () {
                    widget.list?.add(Animal(
                        an: _tc?.value.text,
                        k: getKind(_kc),
                        ip: _ip,
                        f: f));
                  })
            ], mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
  getKind(int radioValue) {
    switch(radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}