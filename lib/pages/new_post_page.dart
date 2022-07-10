import 'dart:convert';

import 'package:cs496_2nd_week/widgets/imagepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;

class NewPostPage extends StatefulWidget {
  NewPostPage({Key? key, required this.newPostController}) : super(key: key);
  final Map<String, TextEditingController> newPostController;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {

  _postRequest(Map<String, TextEditingController> controller) async {
    await dotenv.load();
    String? url = dotenv.env['HOST'];
    String? port = dotenv.env['PORT'];
    if(url == null) { print("_postRequest"); return; }
    Map<String, String> data = {
      'title': controller['title'] != null ? controller['title']!.text : "",
      'githuburl': controller['githuburl'] != null ? controller['githuburl']!.text : "",
      'description': controller['description'] != null ? controller['description']!.text : "",
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
  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              height: 64,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 200, 200, 200),
                    width: 1
                  )
                )
              ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {
                      if(widget.newPostController.values.every((element) => element.text == '')) {
                        Navigator.of(context).pop();
                      }
                      else {
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: FittedBox(fit: BoxFit.fitWidth, child: Text('작성 중인 내용을 삭제하시겠습니까?')),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.pop(context, 'OK');
                                widget.newPostController['title']?.text = '';
                                widget.newPostController['githuburl']?.text = '';
                                widget.newPostController['description']?.text = '';
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ), barrierDismissible: true);
                      }
                    }, icon: const Icon(Icons.clear), splashColor: Colors.black12, splashRadius: 24,),
                    const Text("프로젝트 등록하기", style: const TextStyle(fontSize: 16),),
                    TextButton(onPressed: () {

                    }, style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.black12),
                    ),
                    child: const Text("등록", style: const TextStyle(fontSize: 14, color: Colors.orange)),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9 < 640 ? MediaQuery.of(context).size.width * 0.9 : 640,
                    ),
                    child: Column(
                      children: [
                        const Divider(thickness: 1, color: Colors.transparent,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15 < 160 ? MediaQuery.of(context).size.height * 0.15 : 160,
                          child: Container(
                            color: Colors.amber,
                          ),
                        ),
                        const Divider(thickness: 1,),
                        TextFormField(
                          controller: widget.newPostController['title'],
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "프로젝트 이름",
                          ),
                        ),
                        const Divider(thickness: 1,),
                        TextFormField(
                          controller: widget.newPostController['githuburl'],
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Github 링크 \*"
                          ),
                        ),
                        const Divider(thickness: 1,),
                        TextFormField(
                          controller: widget.newPostController['description'],
                          maxLines: null,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "설명"
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
