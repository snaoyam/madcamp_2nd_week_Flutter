import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 0, MediaQuery.of(context).size.width * 0.1, 0),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Welcome to App!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), ),
            ),
            SizedBox(height: 10,),
            Text('App은 자신이 만든 프로젝트를 공유하고 발전시킬 수 있는 플랫폼입니다', style: TextStyle(fontSize: 16), ),
            SizedBox(height: 10,),
            OutlinedButton(
              onPressed: () {Navigator.pushNamed(context, '/');},
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              child: Row(children: [Icon(Icons.mail_outlined, color: Color.fromARGB(255, 66, 66, 66),), SizedBox(width: 8), Text('Continue with Email', style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),)], mainAxisAlignment: MainAxisAlignment.center,),
            ),
            OutlinedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40)
              ),
              child: Row(children: [Icon(Icons.facebook), SizedBox(width: 8), Text('Continue with Facebook', style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)), )], mainAxisAlignment: MainAxisAlignment.center,),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Register as New User', 
                  style: const TextStyle(color: Color.fromARGB(255, 66, 66, 66), decoration: TextDecoration.underline), 
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}