import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<File>? _imageFile;

  late String _strDownloadProgress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        future: _imageFile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Card(
                  color: Colors.blueGrey,
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text(
                        _strDownloadProgress,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.hasError}");
            } else if (snapshot.hasData) {
              return Column(
                children: <Widget>[Image.file(snapshot.data!)],
              );
            } else {
              return Text('Empty data');
            }
          } else {
            return Text("ConnectionState: ${snapshot.connectionState}");
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () {
          _imageFile = _downloadFile(downloadFilename);
        },
      ),
    );
  }

  Future<File> _downloadFile(String filename) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var filePathSaved = "${appDocDir.path}/$filename";

    String url = "$DOWNLOAD_URL/$filename?$DOWNLOAD_OPTION_STR";

    await Dio().download(url, filePathSaved, onReceiveProgress: (count, total) {
      print("$filePathSaved:Received:$count bytes, Total: $total bytes.");
      setState(() {
        _strDownloadProgress = "Downloading $filename: ${((count/total) * 100).toStringAsFixed(0)}";
      });
    });

    return File(filePathSaved);
  }
}
