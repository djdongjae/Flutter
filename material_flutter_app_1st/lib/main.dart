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
        primarySwatch: Colors.blue,
      ),
      home: MaterialFlutterApp(),
    );
  }
}

// StatefulWidget 클래스를 상속받는 MaterialFlutterApp
class MaterialFlutterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterialFlutterApp();
  }
}

// StatefulWidget을 화면에 출력하기 위한 State 클래스를 상속받는 _MaterialFlutterApp
class _MaterialFlutterApp extends State<MaterialFlutterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material Design App'),),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
          onPressed: () { // 좌측 하단에 플로팅 버튼 추가하기
          },),
      body: Container( // 위젯을 여러 개 만들기
        child: Center( // 가로 중앙 정렬
            child: Column(
              children: <Widget>[Icon(Icons.android), Text('android')],// 위젯
              mainAxisAlignment: MainAxisAlignment.center,
            )
        )
      ),
    );
  }
}
