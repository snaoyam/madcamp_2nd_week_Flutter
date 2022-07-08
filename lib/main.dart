import 'package:cs496_2nd_week/pages/login_page.dart';
import 'package:cs496_2nd_week/pages/main_page.dart';
import 'package:cs496_2nd_week/pages/signup_page.dart';
import 'package:cs496_2nd_week/pages/my_info.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget { // st stl stf
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "cs496 2nd week",
      theme: ThemeData(
          colorScheme:  Theme.of(context).colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.purple,
            primaryContainer: Colors.black,
          )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/myinfo': (context) => MyinfoPage(),
      },
    );
  }
}