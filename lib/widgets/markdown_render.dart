import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';

Future<String> _getTextData(String mdUrl) async{
  String url = 'https://raw.githubusercontent.com/snaoyam/madcamp_1st_week/main/README.md';
  var response = await http.get(Uri.parse(url));


  /*http.Response response = await http.get(
    Uri.parse('https://api.github.com/repos/$_username/$_repository'),
    headers: <String, String> { 'Content-Type': 'application/json', 'Authorization': 'token $_githubToken',}, 
  ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); }); //!*/
  return response.body;
}

class MarkdownRender extends StatelessWidget {
  const MarkdownRender ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: FutureBuilder(
        future: _getTextData('https://raw.githubusercontent.com/snaoyam/madcamp_1st_week/main/README.md'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Markdown(data: snapshot.data.toString());
          }
          return Container();
        }
      ),
    );
  }
}

