import 'dart:convert';
import 'package:cs496_2nd_week/pages/main_page.dart';
import 'package:cs496_2nd_week/widgets/c_select_input.dart';
import 'package:cs496_2nd_week/widgets/c_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../utils/fade_page_route.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static const storage = FlutterSecureStorage();
  Map<String, TextEditingController> textController = {
    'email': TextEditingController(),
    'username': TextEditingController(),
    'password': TextEditingController(),
    'password_check': TextEditingController(),
    'year': TextEditingController(text: '2022 여름'),
    'class': TextEditingController(text: '1'),
  };
  Map<String, int> isError = {
    'email': 0,
    'username': 0,
    'password': 0,
    'password_check': 0,
    'year': 0,
    'class': 0,
  };


  _postRequest(Map<String, TextEditingController> controller) async {
    await dotenv.load();
    String? url = dotenv.env['HOST'];
    String? port = dotenv.env['PORT'];
    if(url == null) { print("_postRequest"); return; }
    Map<String, String> data = {
      'username': controller['username'] != null ? controller['username']!.text : "",
      'password': controller['password'] != null ? controller['password']!.text : "",
      'email': controller['email'] != null ? controller['email']!.text : "",
      'year': controller['year'] != null ? controller['year']!.text : "",
      'class': controller['class'] != null ? controller['class']!.text : "",
    };
    http.Response response = await http.post(
      Uri.parse('http://$url:$port/user/register'),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
      encoding: Encoding.getByName("utf-8"),
    ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); });
    return response;
  }

  _checkinput() {
    setState(() {
      textController.forEach((key, value) { if(value.text == '') {isError[key] = 1;} else {isError[key] = 0;} });
      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch((textController['email'] ?? TextEditingController()).text)) isError['email'] = 2;
      if(((textController['username'] ?? TextEditingController()).text.length < 4) && ((textController['username'] ?? TextEditingController()).text != '')) isError['username'] = 2;
      if(((textController['password'] ?? TextEditingController()).text.length < 4) && ((textController['password'] ?? TextEditingController()).text != '')) isError['password'] = 2;
      if((textController['password'] ?? TextEditingController()).text != (textController['password_check'] ?? TextEditingController()).text) isError['password_check'] = 2;
    });
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
              children: [
                ConstrainedBox(constraints: BoxConstraints(minHeight: 64),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      child: SvgPicture.asset('assets/images/cat0.svg', width: 240,),
                    )
                  ),
                ),
                SizedBox(height: 8,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('환영합니다! >_<', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), ),
                ),
                const SizedBox(height: 4,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('몇 가지 정보로 새로운 계정을 만들어보세요!', style: TextStyle(fontSize: 16), ),
                ),
                const SizedBox(height: 16,),
                Form(
                  child: Column(
                    children: [
                      CTextInput(
                        title: '이름',
                        placeholder: '김몰입',
                        controller: textController['name'],
                        isError: (isError['name'] ?? 0) != 0,
                        errorText: '이름을 입력해주세요.',
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: CSelectInput(
                              title: '몰입캠프 수강 시기',
                              controller: textController['year']!,
                              list: const ['2022 여름', '2021 겨울', '2021 여름', '2020 겨울', '2020 여름', '2019 겨울', '2019 여름'], 
                              placeholder: "placeholder"
                            ),
                          ),
                          const SizedBox(width: 16,),
                          Flexible(
                            flex: 1,
                            child: CSelectInput(
                              title: '분반',
                              controller: textController['class']!,
                              list: const ['1', '2', '3', '4'], 
                              placeholder: "placeholder"
                            ),
                          ),
                        ],
                      ),
                      CTextInput(
                        title: '이메일',
                        placeholder: 'madcamp@example.com',
                        controller: textController['email'],
                        isError: (isError['email'] ?? 0) != 0,
                        errorText: isError['email'] == 2 ? '올바른 이메일을 입력해주세요.' : '이메일을 입력해주세요.',
                      ),
                      CTextInput(
                        title: '아이디',
                        placeholder: 'username',
                        controller: textController['username'],
                        isError: (isError['username'] ?? 0) != 0,
                        errorText: isError['username'] == 2 ? '4자 이상으로 입력해주세요.' : '아이디를 입력해주세요.',
                      ),
                      CTextInput(
                        title: '비밀번호',
                        placeholder: 'password',
                        obscureText: true,
                        controller: textController['password'],
                        isError: (isError['password'] ?? 0) != 0,
                        errorText: isError['password'] == 2 ? '4자 이상으로 입력해주세요.' : '비밀번호를 입력해주세요.',
                      ),
                      CTextInput(
                        title: '비밀번호 확인',
                        placeholder: 're-type password',
                        obscureText: true,
                        controller: textController['password_check'],
                        isError: (isError['password_check'] ?? 0) != 0,
                        errorText: isError['password_check'] == 2 ? '비밀번호가 일치하지 않습니다.' : '비밀번호를 다시 입력해주세요.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                OutlinedButton(
                  onPressed: () async {
                    _checkinput();
                    if(isError.values.every((element) => element == 0)) {
                      http.Response response = await _postRequest(textController);
                      if(response.statusCode >= 200 && response.statusCode < 300) {
                        String token = jsonDecode(response.body)['token'];
                        await storage.write(
                          key: 'token',
                          value: token,
                        ); //storage.delete(key: "login");
                        Navigator.pushReplacement(context, FadePageRoute(MainPage(token: token)));
                      }
                      else {
                        print('wrong id or password');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      //Icon(Icons.face, color: Colors.black), 
                      //SizedBox(width: 8), 
                      Text('회원가입하기', style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)), )
                    ],
                  ),
                ),
                SizedBox(height: 100,),
                //Expanded(child: SizedBox.shrink()),
              ],
            )
          ),
        ),
      )
    );
  }
}


//rSvgPicture.asset('assets/images/cat0.svg', width: 180,),