import 'package:cs496_2nd_week/pages/start_loading_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget { // st stl stf
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "cs496 2nd week",
      theme: ThemeData(
        colorScheme:  Theme.of(context).colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.purple,
          primaryContainer: Colors.black,
        )
      ),
      home: const StartLoadingPage(),
      /*initialRoute: '/login',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },*/
    );
  }
}