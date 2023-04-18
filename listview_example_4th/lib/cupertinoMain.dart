import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'subIos/cupertinoFirstPage.dart';
import 'subIos/cupertinoSecondPage.dart';
import './animalItem.dart';

class CupertinoMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CupertinoMain();
}
class _CupertinoMain extends State<CupertinoMain> {

  CupertinoTabBar? tb;
  List<Animal> al = List.empty(growable: true);

  @override
  void initState() {
    tb = CupertinoTabBar(items:<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add))
    ]);
    al.add(Animal(an:"벌", k:"곤충", ip: "repo/images/bee.png"));
    al.add(Animal(an:"고양이", k:"포유류", ip: "repo/images/cat.png"));
    al.add(Animal(an:"소", k:"포유류", ip: "repo/images/cow.png"));
    al.add(Animal(an:"개", k:"천사", ip: "repo/images/dog.png"));
    al.add(Animal(an:"여우", k:"포유류", ip: "repo/images/fox.png"));
    al.add(Animal(an:"원숭이", k:"영장류", ip: "repo/images/monkey.png"));
    al.add(Animal(an:"돼지", k:"음식", ip: "repo/images/pig.png"));
    al.add(Animal(an:"늑대", k:"포유류", ip: "repo/images/wolf.png"));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tb!,
        tabBuilder: (context, value) {
          if(value == 0) {
            return CupertinoFirstPage(list: al);
          } else {
            return CupertinoSecondPage(list: al);
          }
        },
      ),
    );
  }
}