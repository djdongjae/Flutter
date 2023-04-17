import 'package:flutter/cupertino.dart';
import 'animalItem.dart';
import 'iosSub/cupertinoFirstPage.dart';
import 'iosSub/cupertinoSecondPage.dart';

class CupertinoMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoMain();
  }
}

class _CupertinoMain extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ]);
    animalList.add(Animal(an: "벌", k: "곤충", ip: "repo/images/bee.png"));
    animalList.add(Animal(an: "고양이", k: "포유류", ip: "repo/images/cat.png"));
    animalList.add(Animal(an: "젖소", k: "포유류", ip: "repo/images/cow.png"));
    animalList.add(Animal(an: "강아지", k: "포유류", ip: "repo/images/dog.png"));
    animalList.add(Animal(an: "여우", k: "포유류", ip: "repo/images/fox.png"));
    animalList.add(Animal(an: "원숭이", k: "영장류", ip: "repo/images/monkey.png"));
    animalList.add(Animal(an: "돼지", k: "포유류", ip: "repo/images/pig.png"));
    animalList.add(Animal(an: "늑대", k: "포유류", ip: "repo/images/wolf.png"));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
          tabBar: tabBar!,
          tabBuilder: (context, value) {
            if (value == 0) {
              return CupertinoFirstPage(
                  animalList: animalList);
            } else {
              return CupertinoSecondPage(
                animalList: animalList,
              );
            }
          }),
    );
  }
}
