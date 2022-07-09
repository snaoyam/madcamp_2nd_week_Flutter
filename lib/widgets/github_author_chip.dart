import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GithubAuthorChip extends StatefulWidget {
  GithubAuthorChip({Key? key, this.profileimage, required this.name, required this.height}) : super(key: key);
  String? profileimage;
  final String name;
  final double height;

  @override
  State<GithubAuthorChip> createState() => _GithubAuthorChipState();
}

class _GithubAuthorChipState extends State<GithubAuthorChip> {
  _GithubAuthorChipState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          AspectRatio(aspectRatio: 1, child: ClipOval(
            child: Image.network(
              widget.profileimage ?? '',
              errorBuilder: (context, error, stackTrace) { return CircleAvatar(backgroundColor: Colors.black12,); },
            )
          )),
          SizedBox(width: 2,),
          Text(widget.name, style: TextStyle(fontSize: widget.height-4), textAlign: TextAlign.center,),
          SizedBox(width: 6,),
        ],
      ),
    );
  }
}