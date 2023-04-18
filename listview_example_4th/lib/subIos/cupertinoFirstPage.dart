import 'package:flutter/cupertino.dart';
import '../animalItem.dart';

class CupertinoFirstPage extends StatelessWidget {
  final List<Animal>? list;
  const CupertinoFirstPage({Key? key, required this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Animal List'),),
      child: ListView.builder(
        itemBuilder: (context, position){
          return Container(
            padding: EdgeInsets.all(5), height: 100,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(list![position].ip!, height: 100, width: 100, fit: BoxFit.contain),
                    Text(list![position].an!)
                  ],
                ),
                Container(
                  height: 2, color: CupertinoColors.black,
                )
              ],
            ),
          );
        }, itemCount: list!.length,
      ),
    );
  }
}