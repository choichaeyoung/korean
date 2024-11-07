import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:ionicons/ionicons.dart';
import 'package:korean/components/fab_container.dart';
import 'package:korean/pages/notification.dart';
import 'package:korean/pages/profile.dart';

import 'package:korean/pages/home.dart';
import 'package:korean/pages/test.dart';
import 'package:korean/pages/study.dart';

//import 'package:korean/utils/firebase.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:social_media_app/widgets/icon_badge.dart';
import 'package:badges/badges.dart' as badges;

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _page = 0;

  @override
  void initState() {
    super.initState();

  }


  List pages = [
    {
      'title': 'Practice',
      'icon': Feather.home,
      'page': Home(),
      'index': 0,
    },
    {
      'title': 'Mock',
      'icon': Feather.book_open,
      'page': Test(),
      'index': 1,
    },
    {
      'title': 'Practice',
      'icon': Feather.circle,
      'page': Study(),
      'index': 2,
    },
    {
      'title': 'Notification',
      'icon':Feather.bell,
      'page': Activities(),
      'index': 3,
    },
    {
      'title': 'Profile',
      'icon': Feather.user,
      'page': Profile(memberSeq: GetStorage().read("member")['member_seq']),
      'index': 4,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
        await _onBackPressed(context);
        return false;
      },
      child:Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: pages[_page]['page'],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              for (Map item in pages)
                item['index'] == 3
                    ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                        child:  badges.Badge(
                          position: badges.BadgePosition.topEnd(top: 2, end: 2),
                          //badgeContent: Text('3'),
                          onTap: () {
                            navigationTapped(item['index']);
                          },
                          badgeContent:
                          //Icon(Icons.check, color: Colors.white, size: 10),
                          Text('3', style: TextStyle(
                            fontSize: 12.0,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                          badgeAnimation: badges.BadgeAnimation.rotation(
                            animationDuration: Duration(seconds: 1),
                            colorChangeAnimationDuration: Duration(seconds: 1),
                            loopAnimation: false,
                            curve: Curves.fastOutSlowIn,
                            colorChangeAnimationCurve: Curves.easeInCubic,
                          ),
                          child: IconButton(
                            icon: Icon(
                              item['icon'],
                              color: item['index'] != _page
                                  ? Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black
                                  : Theme.of(context).colorScheme.secondary,
                              size: 25.0,
                            ),
                            onPressed: () => navigationTapped(item['index']),
                          ),
                        ),
                    )
                    : Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          icon: Icon(
                            item['icon'],
                            color: item['index'] != _page
                                ? Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black
                                : Theme.of(context).colorScheme.secondary,
                            size: 25.0,
                          ),
                          onPressed: () => navigationTapped(item['index']),
                        ),
                      ),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }

  buildFab() {
    return Container(
      height: 45.0,
      width: 45.0,
      // ignore: missing_required_param
      child: FabContainer(
        icon: Feather.plus,
        mini: true,
      ),
    );
  }

  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }

  Future<void> _onBackPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) =>
          Material(
            type: MaterialType.transparency,
            child: Center(
              // Aligns the container to center
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.yellow,
                ),
                width: 300,
                height: 300,
                //color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        child: Container(
                            height: 30.0,
                            width: 180,
                            decoration: BoxDecoration(
                              //color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"),
                                  fit: BoxFit.cover
                              ),
                              //child: Text("clickMe") // button text
                            )
                        ), onTap: () {
                      //Navigator.of(context).pop(ConfirmAction.place);
                      Navigator.maybePop(context);
                    }
                    ),
                    SizedBox(height: 10.0),
                    Text("앱을 종료 하시겠습니까?",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 30.0),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        width: 230,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 94,
                              height: 34.0,
                              child: Container(

                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder( //모서리를 둥글게
                                        borderRadius: BorderRadius.circular(5)),
                                    //primary: colorCurve,
                                    // onPrimary: Colors.blue,	//글자색
                                    //minimumSize: Size(200, 50),	//width, height
                                    alignment: Alignment.center,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Text('취소',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black)),
                                      //SizedBox(height: size.getWidthPx(10)),

                                      //upperBoxCard(),
                                    ],
                                  ),
                                ),
                              ),),
                            SizedBox(width: 10.0),
                            SizedBox(
                              width: 94,
                              height: 34.0,
                              child: Container(

                                child: ElevatedButton(
                                  onPressed: () {
                                    //Navigator.of(context).pop(true);
                                    if (Platform.isIOS) {
                                      exit(0);
                                    } else {
                                      SystemNavigator.pop();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder( //모서리를 둥글게
                                        borderRadius: BorderRadius.circular(5)),
                                    //primary: colorCurve,
                                    // onPrimary: Colors.blue,	//글자색
                                    //minimumSize: Size(200, 50),	//width, height
                                    alignment: Alignment.center,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Text('종료',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black)),
                                      //SizedBox(height: size.getWidthPx(10)),

                                      //upperBoxCard(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
