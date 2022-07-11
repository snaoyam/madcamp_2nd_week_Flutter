import 'package:cs496_2nd_week/pages/main_home.dart';
import 'package:cs496_2nd_week/pages/main_my_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer';

class MainPage extends StatefulWidget {
  final token;
  MainPage({this.token, Key? key}) : super(key: key);
  
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        //backgroundColor: Color.fromRGBO(107, 203, 110, 1),
        elevation: 0,
        title: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Align(alignment: Alignment.center,child: Text('Home')),
            Align(alignment: Alignment.center,child: Text('Top Projects')),
            Align(alignment: Alignment.center,child: Text('Achievements')),
            Align(alignment: Alignment.center,child: Text('My Info')),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          MainHome(), Container(), Container(), MyinfoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        //unselectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.green),
        //unselectedIconTheme: const IconThemeData(color: Colors.black),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), activeIcon: Icon(Icons.emoji_events), label: '순위'),
          BottomNavigationBarItem(icon: Icon(Icons.check_outlined), activeIcon: Icon(Icons.check), label: '도전과제'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined), activeIcon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
