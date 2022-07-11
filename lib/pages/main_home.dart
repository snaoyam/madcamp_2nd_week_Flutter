import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:cs496_2nd_week/widgets/project_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', title: 'Madcamp 1st Week', description: 'KKAMITORY is the webpage which contains everything you need in your dormitory.KKAMITORY is the webpage which contains everything you need in your dormitory.KKAMITORY is the webpage which contains everything you need in your dormitory.KKAMITORY is the webpage which contains everything you need in your dormitory. It has Posts page for dormitory community, Reserve page for reservation of dormitory machines, and Report page for a quick report to dormitory teacher.', imageurl: 'https://user-images.githubusercontent.com/68638211/126341027-2bdb5518-bcd4-4325-b034-52fde6ef7ec6.png',),
          ProjectCardView(githuburl: 'https://github.com/T-dubb/Madcamp4-Game-App', title: "test"),
          ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week',),
          ProjectCardView(githuburl: 'https://github.com/sparcs-kaist/otlplus', description: 'KKAMITORY is the webpage which contains everything you need in your dormitory.KKAMITORY is the webpage which contains everything you need in your dormitory.KKAMITORY is the webpage which contains everything you need in your dormitory.KKAMITORY is the webpage which contains everything you need in your dormitory. It has Posts page for dormitory community, Reserve page for reservation of dormitory machines, and Report page for a quick report to dormitory teacher.'),
          ProjectCardView(githuburl: 'https://github.com/snaoyam/madcamp_1st_week', title: 'title'),
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}