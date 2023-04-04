import 'package:flutter/material.dart';

// StatefulWidget을 상속받는 ImageWidgetApp 클래스 생성
class ImageWidgetApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageWidgetApp();
  }
}

// State를 상속받는 _ImageWidgetApp
class _ImageWidgetApp extends State<ImageWidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Widget'),), // 제목 줄 추가하기
      body: Container( // 위젯 여러개 만들기
        child: Center(
          child: Column( // 가로 중앙 정렬
              mainAxisAlignment: MainAxisAlignment.center,// 세로 중앙 정렬
              children: <Widget>[
                Image.asset('image/flutter.png',
                    width: 200, height: 100),
                Text('Hello Flutter',
                  style: TextStyle(fontFamily: 'Pacifico',
                  fontSize: 30, color: Colors.blue),
                  ),
              ]
          ),
        ),
      ),
    );
  }
}