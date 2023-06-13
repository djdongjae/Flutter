import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp> {
  String result = '';
  List? data;
  TextEditingController? _ec;
  ScrollController? _sc;
  int pg = 1;

  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
    _ec = new TextEditingController();
    _sc = new ScrollController();

    _sc!.addListener(() {
      if (_sc!.offset >=
              _sc!.position.maxScrollExtent &&
          !_sc!.position.outOfRange) {
        print('bottom');
        pg++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _ec,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
        child: Center(
            child: data!.length == 0
                ? Text(
                    '데이터가 없습니다.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Image.network(
                                data![index]['thumbnail'],
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Text(
                                      data![index]['title'].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                      '저자 : ${data![index]['authors'].toString()}'),
                                  Text(
                                      '가격: ${data![index]['sale_price'].toString()}'),
                                  Text(
                                      '판매중 : ${data![index]['status'].toString()}'),
                                ],
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                        ),
                      );
                    },
                    itemCount: data!.length,
                    controller: _sc,
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pg = 1;
          data!.clear();
          getJSONData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url = 'https://dapi.kakao.com/v3/search/book?'
        'target=title&page=$pg&query=${_ec!.value.text}';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK b98769026e080b84e737d37ab8056e7c"});
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}
