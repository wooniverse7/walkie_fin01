import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/models/pin_pill_info.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'dart:math' as math;



//자기 상태창

class MapPinPillComponent extends StatefulWidget {
  double pinPillPosition;
  PinInformation currentlySelectedPin;

  //MapPinPillComponent({this.pinPillPosition, this.currentlySelectedPin});
  MapPinPillComponent({this.pinPillPosition});

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {
  var _icon = Icons.play_arrow;
  var _color = Colors.amber;

  Timer _timer;
  var _time = 0;
  var _isPlaying = false;
  List<String> _saveTimes = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sec = _time ~/ 100;
    var _sec = '${sec % 60}';
    var min = sec ~/ 60;
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(20),
          height: 90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(left: 10),
                child: ClipOval(
                    child: Image.asset('assets/pics/normal01.jpg',
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('산책 시간',
                          style: TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.bold)),
                      Text('$min' 'm ' '$_sec' 's',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () => setState(() {
                    _click();
                  }),
                  child: Icon(_icon),
                  backgroundColor: _color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _click() {
    _isPlaying = !_isPlaying;

    if (_isPlaying) {
      _icon = Icons.stop;
      _color = Colors.grey;
      _start();

      //_loadWalker();
    } else {
      _icon = Icons.play_arrow;
      _color = Colors.amber;
      Navigator.push(context,
          MaterialPageRoute<void>(builder: (BuildContext context) {
        return Second();
      }));
      //_showDialog();
      _reset();
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    setState(() {
      _isPlaying = false;
      _timer?.cancel();
      _saveTimes.clear();
      _time = 0;
    });
  }

  void _saveTime(String time) {
    _saveTimes.insert(0, 'SPOT ${_saveTimes.length + 1} : $time');
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.orange,
        elevation: 5,
        title: Text(
          "산책 결과",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.all(10.0),
          //       child: CircleAvatar(
          //         backgroundImage: ExactAssetImage('assets/pics/normal01.jpg'),
          //       ),
          //   )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 10,),
              //  Text("Today", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),),
              SizedBox(
                height: 0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Colors.blue,
                            Colors.blue.withOpacity(.7)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "시간",
                              style:
                              TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "15 분",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Colors.pink,
                            Colors.red.withOpacity(.7)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "거리",
                              style:
                                  TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "1.25 Km",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "산책 코스",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: Image.asset(
                          'assets/course.jpg',
                        width: 300,
                        height: 250,
                      ),
                    ),
                  //  Container(
                  //    width: double.infinity,
                  //    padding: EdgeInsets.all(20),
                  //    decoration: BoxDecoration(
                  //        border: Border(
                  //            bottom: BorderSide(color: Colors.grey[200]))),
                  //    child: Text(
                  //      "사진 업로드",
                  //      style: TextStyle(
                  //          color: Colors.grey[800],
                  //          fontSize: 15,
                  //          fontWeight: FontWeight.bold),
                  //    ),
                  //  ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text('저장',
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 21)),
                                  color: Colors.orange,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0)),
                                ),
                              ),
                              Expanded(
                                child: RaisedButton(
                                  child: Text('닫기',
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 21)),
                                  color: Colors.grey,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
