import 'package:cs496_2nd_week/pages/login_page.dart';
import 'package:cs496_2nd_week/utils/fade_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class StartLoadingPage extends StatefulWidget {
  const StartLoadingPage({Key? key}) : super(key: key);

  @override
  State<StartLoadingPage> createState() => _StartLoadingPageState();
}

class _StartLoadingPageState extends State<StartLoadingPage> {
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkToken();
    });
  }

  Future<void> _checkToken() async {
    try {
      final stopwatch = Stopwatch()..start();

      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('first_run') ?? true) {
        FlutterSecureStorage storage = FlutterSecureStorage();
        await storage.deleteAll();
        prefs.setBool('first_run', false);
      }
      String? token = await storage.read(key: 'token');
      while(stopwatch.elapsedMilliseconds < 500) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
      if(mounted) {
        if(token != null) {
          Navigator.pushAndRemoveUntil(context, FadePageRoute(MainPage(token: token)), (_) => false); //MaterialWithModalsPageRoute
        }
        else {
          Navigator.pushAndRemoveUntil(context, FadePageRoute(const LoginPage()), (_) => false);
        } 
      }
      return;
    } on Exception {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.black,),
      )
    );
  }
}