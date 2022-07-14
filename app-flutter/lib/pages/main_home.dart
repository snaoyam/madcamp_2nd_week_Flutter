import 'dart:convert';

import 'package:cs496_2nd_week/pages/view_post_page.dart';
import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:cs496_2nd_week/widgets/project_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  
  List<Map<String, String>> cardList = [];
  List<Widget> _createChildren() {
    return List<Widget>.generate(cardList.length, (int index) {
      return ProjectCardView(githuburl: cardList.elementAt(index)['githuburl'] ?? '');
    });
  }

  GlobalKey _key = GlobalKey();
  double _position = 1;
  int _iterate = 1;
  int _now = DateTime.now().millisecondsSinceEpoch;
  bool _loading = false;
  var postList = [];
  FlutterSecureStorage storage = FlutterSecureStorage();
  

  _postRequest(int it, int time) async {
    String? url = dotenv.env['HOST'];
    String? port = dotenv.env['PORT'];
    String? token = await storage.read(key: 'token');
    if(url == null) { print("_postRequest"); return; }
    Map<String, String> data = {
      'iterate': it.toString(),
      'time': time.toString(),
    };
    http.Response response = await http.post(
      Uri.parse('http://$url:$port/api/post/home'),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'token': token ?? '',
      },
      body: jsonEncode(data),
      encoding: Encoding.getByName("utf-8"),
    ).timeout(Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); });
    return response;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _postRequest(_iterate++, _now).then((response) {
      setState(() {
        for(var v in jsonDecode(response.body)['postList']) {
          postList.add(v);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        RenderBox box = _key.currentContext?.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        _position = MediaQuery.of(context).size.height - position.dy;
        if(!_loading && _position > 0) {
          _loading = true;
          _postRequest(_iterate++, _now).then((response) {
            setState(() {
              for(var v in jsonDecode(response.body)['postList']) {
                postList.add(v);
              }
            });
          });
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _iterate = 1;
          _now = DateTime.now().millisecondsSinceEpoch;
          postList.clear();
          _postRequest(_iterate++, _now).then((response) {
            setState(() {
              for(var v in jsonDecode(response.body)['postList']) {
                postList.add(v);
              }
            });
          });
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                for(var post in postList) ProjectCardView(githuburl: post['githuburl'], name: post['title'], description: post['description'], imageurl: (post['image'] as List<dynamic>),),
                SizedBox(height: 16, key: _key,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}