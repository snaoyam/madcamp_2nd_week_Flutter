import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> _getTextData(String githuburl) async{
  
  String url = await GithubApi().rawReadme(githuburl);
  String? _githubToken = dotenv.env['GITHUBTOKEN'];
  http.Response response = await http.get(
    Uri.parse(url),
    headers: <String, String> { 'Content-Type': 'application/json', 'Authorization': 'token $_githubToken',}, 
  ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); });
  return response.body;
}

class MarkdownRender extends StatelessWidget {
  const MarkdownRender ({Key? key, required this.githuburl}) : super(key: key);
  final String githuburl;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTextData(githuburl),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          return Markdown(
            data: snapshot.data.toString(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
            onTapLink: (_, url, __) async {
              Uri openUrl = Uri.parse(url ?? '');
              if (await canLaunchUrl(openUrl)) {
                launchUrl(openUrl, mode: LaunchMode.inAppWebView);
              }
            },
          );
        }
        else {
          return Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 230, 230, 230),
            highlightColor: const Color.fromARGB(255, 245, 245, 245),
            child: Column(
              children: [
                Container(height: 14, color: Colors.white,),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(
                      children: [ for(var i = 229; i > 0; i-- ) const WidgetSpan(
                        child: Padding(padding: EdgeInsets.only(bottom: 10), child: Text("█", style: TextStyle(fontSize: 12))),
                      ) ]
                    )
                  ),
                ),
              ],
            )
          );
        }
      }
    );
  }
}

