import 'dart:convert';
import 'dart:io';

import 'package:cs496_2nd_week/widgets/imagepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;

class NewPostPage extends StatefulWidget {
  NewPostPage({Key? key, required this.newPostController}) : super(key: key);
  final Map<String, TextEditingController> newPostController;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  
  List<XFile>? _imageFileList = [];

  void _addImageFile(XFile? value) {
    if(value != null) {
      _imageFileList = (_imageFileList ?? [])..add(value);
    }
  }

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
  _checkinput() {
    String checkurl = widget.newPostController['githuburl']?.text ?? '';
    if(!checkurl.startsWith('http')) {
      checkurl = 'https://' + checkurl;
    }
    Uri urlParse = Uri.parse(checkurl);
    setState(() {
      if(urlParse.host.endsWith('github.com')) {
        widget.newPostController['githuburlError']?.text = '0';
      }
      else {
        widget.newPostController['githuburlError']?.text = '1';
      }
    });
  }


  Future _pickImageCamera() async {
    try {
      final XFile? cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        _addImageFile(cameraImage);
      });
      return;
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  Future _pickImageGallery() async {
    try {
      final List<XFile>? pickedFileList = await ImagePicker().pickMultiImage(
        maxWidth: 4096,
        maxHeight: 4096,
      );
      setState(() {
        for(XFile image in (pickedFileList ?? [])) {
          _addImageFile(image);
        }
      });
    } on Exception catch (e) {
      print(e);
    }
    return;
  }

  Widget photobottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "프로젝트 홍보용 사진을 선택하세요",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.black54,
                ),
                icon: Icon(Icons.camera),
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  _pickImageCamera();
                },
                label: Text("카메라"),
              ),
              SizedBox(width: 16,),
              TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.black54,
                ),
                icon: Icon(Icons.image),
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  _pickImageGallery();
                },
                label: Text("갤러리"),
              ),
            ],
          )
        ],
      ),
    );
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
                      if(widget.newPostController['title']?.text == '' && widget.newPostController['githuburl']?.text == '' && widget.newPostController['description']?.text == '' && (_imageFileList ?? []).length == 0) {
                        widget.newPostController['githuburlError']?.text = '0';
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
                                widget.newPostController['githuburlError']?.text = '0';
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
                      _checkinput();
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
                        Align(alignment: Alignment.centerLeft, child: Text("사진 추가", style: TextStyle(fontSize: 16, color: Colors.black54),)),
                        SizedBox(height: 4,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) => photobottomSheet());
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.12 < 160 ? MediaQuery.of(context).size.height * 0.12 : 160,
                                    child: AspectRatio(aspectRatio: 1, 
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(6),
                                        padding: EdgeInsets.all(4),
                                        dashPattern: [8, 6],
                                        color: Colors.black54,
                                        strokeWidth: 1,
                                        child: const Center(
                                          child: Icon(Icons.add, size: 40,),
                                        )
                                      ),
                                    )
                                  ),
                                ),
                                for(XFile image in (_imageFileList ?? [])) Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.12 < 160 ? MediaQuery.of(context).size.height * 0.12 : 160,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Stack(
                                        alignment: AlignmentDirectional.topEnd,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Image.file(File(image.path))
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.clear), 
                                            color: Colors.white,
                                            splashRadius: 1,
                                            splashColor: Colors.transparent,
                                            onPressed: () {
                                              setState(() {
                                                _imageFileList?.removeWhere((element) => element.name == image.name);
                                              });
                                            },
                                            padding: EdgeInsets.all(4),
                                            constraints: BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                        if((widget.newPostController['githuburlError']?.text ?? '0') != '0') const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('올바른 Github 프로젝트 링크를 입력해주세요.', style: const TextStyle(fontSize: 14, color: Colors.red)), 
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
