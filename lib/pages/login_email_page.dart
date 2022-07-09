import 'dart:convert';
import 'package:cs496_2nd_week/pages/main_page.dart';
import 'package:cs496_2nd_week/pages/signup_page.dart';
import 'package:cs496_2nd_week/utils/fade_page_route.dart';
import 'package:cs496_2nd_week/widgets/base_app_bar.dart';
import 'package:cs496_2nd_week/widgets/c_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  static const storage = FlutterSecureStorage();

  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();

  _postRequest(String username, String password) async {
    String? url = dotenv.env['HOST'];
    String? port = dotenv.env['PORT'];
    if(url == null) { print("_postRequest"); return; }
    Map<String, String> data = {
      'username': username,
      'password': password,
    };
    http.Response response = await http.post(
      Uri.parse('http://$url:$port/user/login'),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
      encoding: Encoding.getByName("utf-8"),
    ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                SizedBox(height: 16,),
                CTextInput(
                  title: '아이디 또는 이메일',
                  placeholder: 'username or email address',
                  controller: idController,
                ),
                CTextInput(
                  title: '비밀번호',
                  placeholder: 'Password',
                  obscureText: true,
                  controller: passController,
                ),
                OutlinedButton(
                  onPressed: () async {
                    if(idController.text.toString() != '' && passController.text.toString() != '') {
                      http.Response response = await _postRequest(idController.text, passController.text);
                      if(response.statusCode >= 200 && response.statusCode < 300) {
                        print(jsonDecode(response.body)['token']);
                        await storage.write(
                          key: 'token',
                          value: jsonDecode(response.body)['token'],
                        ); //storage.delete(key: "login");
                        Navigator.pushReplacement(context, FadePageRoute(MainPage(token: '${idController.text}.${passController.text}')));
                      }
                      else {
                        print('wrong id or password');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  child: const Text("로그인", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 2,),
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