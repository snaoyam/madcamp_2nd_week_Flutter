import 'package:cs496_2nd_week/pages/main_page.dart';
import 'package:cs496_2nd_week/utils/fade_page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  static const storage = FlutterSecureStorage();

  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  
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
            Form(child: Column(
              children: [
                CupertinoTextField(
                  placeholder: "ID or email address",
                  padding: EdgeInsets.all(12),
                  controller: idController,
                  style: TextStyle(fontSize: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 4,),
                CupertinoTextField(
                  placeholder: "Password",
                  obscureText: true,
                  padding: EdgeInsets.all(12),
                  controller: passController,
                  style: TextStyle(fontSize: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 4,),
                OutlinedButton(
                  onPressed: () async {
                    if(idController.text.toString() != '' && passController.text.toString() != '') {
                      await storage.write(
                        key: "login",
                        value: "${idController.text}.${passController.text}",
                      ); //storage.delete(key: "login");
                      Navigator.pushReplacement(context, FadePageRoute(MainPage(token: "${idController.text}.${passController.text}")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  child: Text("로그인", style: TextStyle(fontSize: 16)),
                ),
              ],
            ))
          ],
        ),
      )
    );
  }
}