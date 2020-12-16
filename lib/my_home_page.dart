import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/pages/home/index.dart';
import 'package:flutter_app_map_test01/screens/camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/feed_screen.dart';

import 'package:flutter_app_map_test01/screens/profile_screens.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //하단버튼 위젯 모양 설정
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: ""),
    //BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: ""),
  ];

  int _selectedIndex = 1;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    ProfileScreens(),
    MapPage(),
    //카메라 탭
    // Container(
    //   color: Colors.blueAccent,
    // ),
    FeedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _key,
      //앱의 기본 구성
      appBar: AppBar(
        title: Text('Walkie'),
        backgroundColor: Colors.orange,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      //하단 버튼 위젯
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.orange,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick, //버튼 클릭
      ),
    );
  }

  void _onBtmItemClick(int index) {
    // switch (index) {
    //   case 2:
    //     _openCamera();
    //     break;
    //   default:
    //     print(index);
        //extend state class 안에서만 사용가능한 함수
        setState(() {
          _selectedIndex = index; //값을 변화(모양 변화)
        });
    }
  }

//   void _openCamera() {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => CameraScreen()));
//   }
//
//   Future<bool> checkIfPermissionGranted(BuildContext context) async{
//     Map<Permission, PermissionStatus> statuses = await[Permission.camera, Permission.microphone].request();
//     bool permitted = true;
//
//     statuses.forEach((Permission, PermissionStatus) {
//
//     });
//
//
// }
