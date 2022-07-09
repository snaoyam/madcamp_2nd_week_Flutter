import 'dart:ui';

import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:cs496_2nd_week/widgets/github_author_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProjectCardView extends StatefulWidget {
  const ProjectCardView({Key? key, required this.title, this.description = '', this.imageurl = ''}) : super(key: key);
  final String title;
  final String description;
  final String imageurl;

  @override
  State<ProjectCardView> createState() => _ProjectCardViewState();
}

class _ProjectCardViewState extends State<ProjectCardView> {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GithubApi().contributors('https://github.com/snaoyam/madcamp_1st_week/tree/main/gradle/wrapper'),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: Card(
              margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(widget.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                        Row(
                          children: [ for(var v in (snapshot.data as List<dynamic>)) GithubAuthorChip(name: v['login'], profileimage: v['avatar_url'], height: 16) ]
                        )
                      ],
                    ),
                    AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Image.network(
                        'assets/images/', 
                        fit: BoxFit.cover, 
                        errorBuilder: (context, error, stackTrace) { return Container(color: Colors.black12,); },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        else {
          return SizedBox();
        }
      },
      
    );
  }
} 