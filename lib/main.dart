import 'package:cs496_2nd_week/pages/start_loading_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget { // st stl stf
  const MainApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "cs496 2nd week",
      theme: ThemeData(
        colorScheme:  Theme.of(context).colorScheme.copyWith(
          primary: Color(0xFFADCB00),
          secondary: Colors.amber,
        )
      ),
      home: const StartLoadingPage(),
      /*initialRoute: '/login',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/myinfo': (context) => MyinfoPage(),
      },*/
    );
  }
}