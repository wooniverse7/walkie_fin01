import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/Widgets/take_photo.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String _title = 'Photo';

  @override
  //메모리 누수 막기
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            color: Colors.cyanAccent,
          ),
          TakePhoto(),
          Container(
            color: Colors.yellowAccent,
          ),
        ],
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
            switch(_currentIndex){
              case 0:
                _title='Gallery';
                break;
              case 1:
                _title = 'Photo';
                break;
              case 2:
                _title = 'Video';
                break;
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: ("GALLERY")),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: ("PHOTO")),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: ("VIDEO")),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTabbed,
      ),
    );
  }

  void _onItemTabbed(index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}

