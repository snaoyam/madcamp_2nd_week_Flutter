import 'package:carousel_slider/carousel_slider.dart';
import 'package:cs496_2nd_week/widgets/github_author_chip.dart';
import 'package:cs496_2nd_week/widgets/markdown_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ViewPostPage extends StatefulWidget {
  ViewPostPage({Key? key, this.description = '', required this.imageurl, this.name = '', required this.githuburl, this.authorchip = const []}) : super(key: key);
  String name;
  final List<dynamic?> imageurl;
  String description;
  final String githuburl;
  List<dynamic> authorchip;
  
  
  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {

  GlobalKey _key = GlobalKey();
  double _position = 1000.0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        //backgroundColor: Color.fromRGBO(107, 203, 110, 1),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: _position > 100 ? Colors.transparent : Color.fromRGBO(173, 203, 0, (1 - _position/100) > 1 ? 1 : (1 - _position/100)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: (_) {
          RenderBox box = _key.currentContext?.findRenderObject() as RenderBox;
          Offset position = box.localToGlobal(Offset.zero);
          setState(() {
            _position = position.dy;
          });
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: CarouselSlider(
                    options: CarouselOptions(),
                    items: widget.imageurl.map((urli) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: urli != null ? Image.network('http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}/uploads/$urli', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Container(color: const Color.fromARGB(255, 230, 230, 230),);} ) : null,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                //Image.asset('assets/images/empty.png'),
              ),
              Padding(
                key: _key,
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft, 
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(widget.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.0),)
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [ 
                            for(var v in widget.authorchip) GithubAuthorChip(name: v['login'], profileimage: v['avatar_url'], height: 16)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: widget.description,
                            style: const TextStyle(color: Colors.black, fontSize: 16,),
                          ), 
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.black54, indent: 12, endIndent: 12, height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: const TextSpan(
                            text: 'README.md',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                    MarkdownRender(githuburl: widget.githuburl),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}