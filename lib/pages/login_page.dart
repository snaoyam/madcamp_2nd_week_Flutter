import 'package:cs496_2nd_week/pages/login_email_page.dart';
import 'package:cs496_2nd_week/pages/main_page.dart';
import 'package:cs496_2nd_week/pages/signup_page.dart';
import 'package:cs496_2nd_week/utils/fade_page_route.dart';
import 'package:cs496_2nd_week/widgets/kakao_login.dart';
import 'package:cs496_2nd_week/widgets/main_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cs496_2nd_week/widgets/main_view_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  final viewModel = MainViewModel(KakaoLogin());
  static const storage = FlutterSecureStorage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8 < 500 ? MediaQuery.of(context).size.width * 0.8 : 500,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Welcome to App!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), ),
                  ),
                  const SizedBox(height: 10,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('App은 자신이 만든 프로젝트를 공유하고 발전시킬 수 있는 플랫폼입니다', style: TextStyle(fontSize: 16), ),
                  ),
                  const SizedBox(height: 10,),
                  OutlinedButton(
                    onPressed: () async {
                      await widget.viewModel.login();
                      setState((){});
                      print("email is ${widget.viewModel.user?.kakaoAccount?.email}");
                      Navigator.pushReplacement(context, FadePageRoute(MainPage(token: widget.viewModel.user?.kakaoAccount?.email)));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/login_googleIcon.png', width: 20, height: 20, ),
                        const SizedBox(width: 8),
                        const Text('Continue with Kakao', style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)), )
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.facebook, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Continue with Facebook', style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)), )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: const <Widget>[
                      Expanded(
                          child: Divider(color: Colors.black54,)
                      ),
                      SizedBox(width:8, ),
                      Text("OR"),
                      SizedBox(width:8, ),
                      Expanded(
                          child: Divider(color: Colors.black54,)
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginEmailPage()),);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mail_outlined, color: Color.fromARGB(255, 66, 66, 66),),
                        SizedBox(width: 8),
                        Text('Continue with Email', style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)), )
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: 'Register as New Email User',
                        style: const TextStyle(color: Color.fromARGB(255, 66, 66, 66), decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()),);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
