import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Map<String, TextEditingController> textController = {
    'email': TextEditingController(),
    'id': TextEditingController(),
    'password': TextEditingController(),
    'passwrod_check': TextEditingController(),
  };
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 0, MediaQuery.of(context).size.width * 0.1, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container(alignment: Alignment.bottomCenter,child: SvgPicture.asset('assets/images/cat0.svg', width: 180,),)),
            SizedBox(height: 24,),
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('이메일', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 105, 105, 105)), ),
            ),
            CupertinoTextField(
              placeholder: "madcamp@example.com",
              padding: EdgeInsets.all(12),
              controller: textController['email'],
              style: TextStyle(fontSize: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('아이디', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 105, 105, 105)), ),
            ),
            CupertinoTextField(
              placeholder: "madcamp",
              padding: EdgeInsets.all(12),
              controller: textController['id'],
              style: TextStyle(fontSize: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('비밀번호', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 105, 105, 105)), ),
            ),
            CupertinoTextField(
              placeholder: "password",
              obscureText: true,
              padding: EdgeInsets.all(12),
              controller: textController['password'],
              style: TextStyle(fontSize: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('비밀번호 확인', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 105, 105, 105)), ),
            ),
            CupertinoTextField(
              placeholder: "re-type password",
              obscureText: true,
              padding: EdgeInsets.all(12),
              controller: textController['password_check'],
              style: TextStyle(fontSize: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 24,),
            OutlinedButton(
              onPressed: () {},
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
            SizedBox(height: 50),
            Expanded(child: SizedBox.shrink()),
          ],
        ),
      )
    );
  }
}


//rSvgPicture.asset('assets/images/cat0.svg', width: 180,),