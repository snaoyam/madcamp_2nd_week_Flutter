import 'package:cs496_2nd_week/pages/view_post_page.dart';
import 'package:cs496_2nd_week/utils/github_api.dart';
import 'package:cs496_2nd_week/widgets/github_author_chip.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProjectCardView extends StatefulWidget {
  ProjectCardView({Key? key, this.name = ' ', this.description = ' ', this.imageurl = const [], required this.githuburl}) : super(key: key);
  String name;
  String description;
  List<String> imageurl;
  String githuburl;

  @override
  State<ProjectCardView> createState() => _ProjectCardViewState();
}

class _ProjectCardViewState extends State<ProjectCardView> {
  Map<String, String> pinfo = {};
  List<dynamic> con = [];
  @override 
  void initState() {
    // TODO: implement initState
    super.initState();
    GithubApi().projectInfo(widget.githuburl, widget.name, widget.description).then(
      (value){
        pinfo = (value as Map<String, String>);
        setState(() {
          
        });
      }
    ); 
    GithubApi().contributors(widget.githuburl).then((value){
      con = value;
      setState(() {

      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPostPage(githuburl: widget.githuburl, name: pinfo['name']??' ', description: pinfo['description']??' ', imageurl: widget.imageurl, authorchip: con)),);
              },
              child: Card(
                margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth, 
                        child: Text(pinfo['name'] ?? ' ', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.0),)
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex:3,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2, bottom: 4),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        text: TextSpan(
                                          children: [ for(var v in (con as List<dynamic>)) WidgetSpan(
                                            child: GithubAuthorChip(name: v['login'], profileimage: v['avatar_url'], height: 16),
                                          ) ]
                                        )
                                      )
                                    ),
                                  ),
                                  Flexible(fit: FlexFit.tight, child: ShaderMask(
                                    shaderCallback: (Rect bound){
                                      return const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.white,Colors.transparent],
                                        stops: [0.8, 1]
                                      ).createShader(bound);
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: pinfo['description'],
                                          style: const TextStyle(color: Colors.black, fontSize: 14,),
                                        ), 
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10, left: 10),
                                child: Image.network( //CachedNetworkImage
                                  (widget.imageurl.isNotEmpty ? widget.imageurl.first : ' '),
                                  fit: BoxFit.cover, 
                                  errorBuilder: (context, error, stackTrace) { return Container(color: const Color.fromARGB(255, 230, 230, 230),); },
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
    );
    }
            
} 

