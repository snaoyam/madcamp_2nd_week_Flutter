import 'package:cs496_2nd_week/pages/start_loading_page.dart';
import 'package:cs496_2nd_week/utils/fade_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cs496_2nd_week/widgets/kakao_login.dart';
import 'package:cs496_2nd_week/widgets/main_view_model.dart';
import 'package:flutter/src/widgets/framework.dart';


class MyinfoPage extends StatefulWidget {
  MyinfoPage({Key? key}) : super(key: key);

  @override
  State<MyinfoPage> createState() => _MyinfoPageState();
}

class _MyinfoPageState extends State<MyinfoPage> {

  final viewModel = MainViewModel(KakaoLogin());
  static const storage = FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(
                          'https://static.vecteezy.com/system/resources/previews/001/188/566/original/fire-png.png',
                        ).image,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {},
                    child: Row(children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Text("User Name" , style: Theme.of(context).textTheme.bodyText1)),
                      Icon(Icons.arrow_forward_ios)
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {},
                    child: Row(children: [
                      Icon(
                        Icons.school_outlined,
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Text("School" , style: Theme.of(context).textTheme.bodyText1)),
                      Icon(Icons.arrow_forward_ios)
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {},
                    child: Row(children: [
                      Icon(
                        Icons.emoji_events_outlined,
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Text("My Score" , style: Theme.of(context).textTheme.bodyText1)),
                      Icon(Icons.arrow_forward_ios)
                    ]),
                  ),
                ),Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () async{
                      storage.delete(key: 'token');
                      print('logged in = ${widget}');
                      await viewModel.logout();
                      setState(() {});
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartLoadingPage()),);
                    },
                    child: Row(children: [
                      Icon(
                        Icons.logout_outlined,
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Text("Log Out" , style: Theme.of(context).textTheme.bodyText1)),
                      Icon(Icons.arrow_forward_ios)
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
// class MyinfoPage extends StatelessWidget {
//   MyinfoPage({Key? key}) : super(key: key);
//
//   final viewModel = MainViewModel(KakaoLogin());
//   static const storage = FlutterSecureStorage();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: PreferredSize(
//       //   preferredSize: Size.fromHeight(20),
//       //   child: AppBar(
//       //     title: '',
//       //     backgroundColor: Color(0xFF7C74E9),
//       //     automaticallyImplyLeading: true,
//       //     actions: [],
//       //     elevation: 2,
//       //   ),
//       // ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Color(0xFFEEEEEE),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: Image.network(
//                           'https://static.vecteezy.com/system/resources/previews/001/188/566/original/fire-png.png',
//                         ).image,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: FlatButton(
//                     padding: EdgeInsets.all(20),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     color: Color(0xFFF5F6F9),
//                     onPressed: () {},
//                     child: Row(children: [
//                       Icon(
//                         Icons.account_circle_outlined,
//                         size: 40,
//                         color: Colors.purple,
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(child: Text("User Name" , style: Theme.of(context).textTheme.bodyText1)),
//                       Icon(Icons.arrow_forward_ios)
//                     ]),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: FlatButton(
//                     padding: EdgeInsets.all(20),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     color: Color(0xFFF5F6F9),
//                     onPressed: () {},
//                     child: Row(children: [
//                       Icon(
//                         Icons.school_outlined,
//                         size: 40,
//                         color: Colors.purple,
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(child: Text("School" , style: Theme.of(context).textTheme.bodyText1)),
//                       Icon(Icons.arrow_forward_ios)
//                     ]),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: FlatButton(
//                     padding: EdgeInsets.all(20),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     color: Color(0xFFF5F6F9),
//                     onPressed: () {},
//                     child: Row(children: [
//                       Icon(
//                         Icons.emoji_events_outlined,
//                         size: 40,
//                         color: Colors.purple,
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(child: Text("My Score" , style: Theme.of(context).textTheme.bodyText1)),
//                       Icon(Icons.arrow_forward_ios)
//                     ]),
//                   ),
//                 ),Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: FlatButton(
//                     padding: EdgeInsets.all(20),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     color: Color(0xFFF5F6F9),
//                     onPressed: () async{
//                       storage.delete(key: 'token');
//                       if(viewModel.isLogined==true){
//                         await viewModel.logout();
//                         setState(() {});
//                       }
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartLoadingPage()),);
//                     },
//                     child: Row(children: [
//                       Icon(
//                         Icons.logout_outlined,
//                         size: 40,
//                         color: Colors.purple,
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(child: Text("Log Out" , style: Theme.of(context).textTheme.bodyText1)),
//                       Icon(Icons.arrow_forward_ios)
//                     ]),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
