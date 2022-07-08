import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BaseAppBar({Key? key, required this.appBar, required this.title, this.center = false}) : super(key: key);
  final AppBar appBar;
  final String title;
  final bool center;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        onPressed: () => Navigator.of(context).pop(),
      ),
      shadowColor: Colors.transparent,
      shape: Border(
        bottom: BorderSide(
          color: Color.fromARGB(255, 96, 96, 96),
          width: 0.5
        )
      ),
      elevation: 4,
      backgroundColor: Colors.transparent,
      centerTitle: center,
      title: Text('', style: TextStyle(color: Colors.black),),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}