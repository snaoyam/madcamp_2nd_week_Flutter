import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class VideoSelect extends StatefulWidget {
  const VideoSelect({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<VideoSelect> createState() => _VideoSelectState();
}

class _VideoSelectState extends State<VideoSelect> {
  File? _video;
  final picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;

  pickVideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);

    _video = File(video!.path);

    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  pickVideoCamera() async {
    final video = await picker.getVideo(source: ImageSource.camera);

    _video = File(video!.path);

    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Column(children: [
                        if (_video != null)
                          _videoPlayerController!.value.isInitialized
                              ? AspectRatio(
                            aspectRatio:
                            _videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController!),

                          )
                              : Container()
                        else
                          Image.network("https://thumbs.dreamstime.com/b/light-abstract-empty-square-transparent-background-pattern-vector-231364928.jpg", width: 400,)
                      ]),
                      Align(
                        alignment: AlignmentDirectional(0.85, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.library_add_sharp,
                            color: Colors.black,
                            size: 50,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) => bottomSheet());
                          },
                        ),
                      ),
                    ],
                  ), // Markdown(data: markdown)
                ],
              )),
        ));
  }

  Widget nameTextField() {
    return CupertinoTextField(
      placeholder: "ID or email address",
      padding: EdgeInsets.all(12),
      controller: titleController,
      style: TextStyle(fontSize: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "프로젝트 홍보용 사진을 선택하세요",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  pickVideoCamera();
                },
                label: Text("카메라"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  pickVideo();
                },
                label: Text("갤러리"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
