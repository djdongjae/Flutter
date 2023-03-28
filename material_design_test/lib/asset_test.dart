import 'package:flutter/material.dart';

class AssetTest extends StatefulWidget {
  final String title;

  const AssetTest({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _AssetTest();

}

class _AssetTest extends State<AssetTest> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/짬뽕.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              Text("Flutter",
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        )
      ),
    );
  }
}