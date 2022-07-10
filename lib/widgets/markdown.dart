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

Future<String> getTextData() async{
  String url = 'https://raw.githubusercontent.com/snaoyam/madcamp_1st_week/main/README.md';
  var response = await http.get(Uri.parse(url));
  return response.body;
}

class MarkDown extends StatelessWidget {
  const MarkDown ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: getTextData(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Markdown(data: snapshot.data.toString());
                  }
                  return Container();
                }
            )
        )
    );
  }
}

