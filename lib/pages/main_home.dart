import 'package:cs496_2nd_week/pages/view_post_page.dart';
import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:cs496_2nd_week/widgets/project_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
  double _position = 1000.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        RenderBox box = _key.currentContext?.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        setState(() {
          _position = position.dy;
        });
        //print(_position);
        return false;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', name: 'Madcamp 1st Week', description: 'nameadkkasd', imageurl: ['https://user-images.githubusercontent.com/68638211/126341027-2bdb5518-bcd4-4325-b034-52fde6ef7ec6.png'],),
            ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', name: 'Madcamp 1st Week', description: 'nameadkkasd', imageurl: [],),
            ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', name: 'Madcamp 1st Week', description: 'nameadkkasd', imageurl: ['https://user-images.githubusercontent.com/68638211/126341027-2bdb5518-bcd4-4325-b034-52fde6ef7ec6.png'],),
            ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', name: 'Madcamp 1st Week', description: 'nameadkkasd', imageurl: ['https://user-images.githubusercontent.com/68638211/126341027-2bdb5518-bcd4-4325-b034-52fde6ef7ec6.png'],),
            ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', name: 'Madcamp 1st Week', description: 'nameadkkasd', imageurl: [],),
            SizedBox(height: 16, key: _key,),
          ],
        ),
      ),
    );
  }
}