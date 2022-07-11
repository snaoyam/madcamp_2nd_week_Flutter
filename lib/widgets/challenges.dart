import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Challenges(),
    );
  }
}

class Challenges extends StatefulWidget {
  const Challenges({Key? key}) : super(key: key);

  @override
  State<Challenges> createState() => _ChallengesState();
}

_getSize(GlobalKey key) {
  if (key.currentContext != null) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    return size;
  }
}

GlobalKey _cardSizeKey = GlobalKey();
final cardWidth = _getSize(_cardSizeKey).width;

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      children: [
        Card(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Color(0xffD9E5FF),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3621/3621723.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('첫 프로젝트\n 등록'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 프로젝트 수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Colors.amber.shade200,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/329/329588.png",
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('조회 수\n5개 이상'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 조회수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Colors.blue.shade300,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/408/408472.png",
                    ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('추천 수\n5개 이상'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 추천수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Colors.pink.shade200,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/905/905750.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('프로젝트 수\n2개 이상'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 프로젝트 수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Color(0xffD9E5FF),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3621/3621723.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('조회수 5개 이상 달성!'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 조회수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(
            key: _cardSizeKey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Colors.amber.shade200,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/329/329588.png",
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('조회수 5개 이상 달성!'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 조회수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Colors.blue.shade300,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/408/408472.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('조회수 5개 이상 달성!'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 조회수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Colors.pink.shade200,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/905/905750.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('조회수 5개 이상 달성!'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 조회수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
            elevation: 5,
            color: Color(0xffD9E5FF),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3621/3621723.png",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text('조회수 5개 이상 달성!'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '현재 조회수 : ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Card(
          color: Colors.red.shade200,
        ),
        Card(
          color: Colors.purple.shade300,
        ),
        Card(color: Colors.green.shade400),
        Card(
          color: Colors.teal.shade200,
        ),
        Card(
          color: Colors.green.shade300,
        ),
        Card(color: Colors.indigo.shade400),
      ],
    ));
  }
}
