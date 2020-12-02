import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_app_map_test01/components/map_pin_pill.dart';
import 'map_utils.dart';
import 'dart:math' as math;

const LatLng SOURCE_LOCATION = LatLng(37.452699, 126.655478);


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _mapController;
  Uint8List _walker;
  Marker _myMarker;

  double pinPillPosition = 0;
//  PinInformation currentlySelectedPin = PinInformation(
//    pinPath: '',
//    avatarPath: '',
//    location: LatLng(0, 0),
//    locationName: '',
//    labelColor: Colors.grey);
//  PinInformation sourcePinInfo;
//
//
//
//  sourcePinInfo = Pininformation(
//      locationName: "현재 위치",
//      location: SOURCE_LOCATION,
//      pinPath:
//      )


  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.452699, 126.655478),
    zoom: 17,
  );

  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> _markers= Map();
  Map<PolylineId, Polyline> _polylines = Map();
  List<LatLng> _myRoute = List();

  Position _lastPosition;

  @override
  void initState() {
    super.initState();
    _loadWalker();
  }

  _loadWalker() async{
    _walker = await MapUtils.loadPinFromAsset('assets/icons/walking_pin.png',width: 100);

    //_startTracking();
  }

  _startTracking() {
    final geolocator = Geolocator();
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);

    _positionStream = Geolocator.getPositionStream().listen(_onLocationUpdate);
    //.getPostionStream(locationOptions)
  }

  _onLocationUpdate(Position position){
    if(position!=null){
      final myPosition = LatLng(position.latitude, position.longitude);
      _myRoute.add(myPosition);

      final myPolyline = Polyline(
          polylineId: PolylineId("me"),
          points: _myRoute,
          color: Colors.orange,
          width: 5);

      if(_myMarker==null){
        final markerId = MarkerId("me");
        final bitMap = BitmapDescriptor.fromBytes(_walker);
        _myMarker = Marker(
            markerId:markerId,
            position: myPosition,
            icon: bitMap,
            rotation: 0,
            anchor: Offset(0.5, 0.5)
        );
      }else{
        final rotation = _getMyBearing(_lastPosition, position);
        _myMarker = _myMarker.copyWith(
            positionParam: myPosition, rotationParam: 0);
      }

      setState(() {
        _markers[_myMarker.markerId] = _myMarker;
        _polylines[myPolyline.polylineId] = myPolyline;
      });
      _lastPosition = position;
      _move(position);
    }
  }

  double _getMyBearing(Position lastPosition,Position currentPosition){
    final dx = math.cos(math.pi/180*lastPosition.latitude)*
        (currentPosition.longitude-lastPosition.longitude);
    final dy = currentPosition.latitude-lastPosition.latitude;
    final angle = math.atan2(dy, dx);
    return 90 - angle*180/math.pi;
  }

  @override
  void dispose() {
    _timer?.cancel();

    if(_positionStream!=null){
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }

  _move(Position position){
    final cameraUpdate =
    CameraUpdate.newLatLng(LatLng(position.latitude,position.longitude));
    _mapController.animateCamera(cameraUpdate);
  }

  _updateMarkerPosition(MarkerId markerId, LatLng p){
    print("newPosition");
    _markers[markerId] = _markers[markerId].copyWith(positionParam: p);
  }

  _onMarkerTap(String id){
    showDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: Text("Click"),
        content: Text("marker id $id"),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            onPressed: ()=>Navigator.pop(context),
          )
        ],
      );
    });
  }

  _onTap(LatLng p){
    final id = "${_markers.length}";
    final markerId = MarkerId(id);
    // final infoWindow = InfoWindow(title: "marker $id",
    //     snippet: "${p.latitude}, ${p.longitude}", anchor: Offset(0.5,0), onTap: (){
    //   print("clicked info $id");
    //     });
    final marker = Marker(
        markerId: markerId,
        position: p,
        draggable: true,
        onTap: ()=>_onMarkerTap(id),
        onDragEnd: (np)=> _updateMarkerPosition(markerId,np));
    setState(() {
      _markers[markerId] = marker;
    });

  }

  var _icon = Icons.play_arrow;
  var _color = Colors.amber;

  Timer _timer;
  var _time = 0;
  var _isPlaying = false;
  List<String> _saveTimes = [];

  @override
  Widget build(BuildContext context) {



    var sec = _time ~/ 100;
    var _sec = '${sec % 60}';
    var min = sec ~/ 60;

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  //onTap: _onTap,
                  markers: Set.of(_markers.values),
                  polylines: Set.of(_polylines.values),
                  onMapCreated: (GoogleMapController controller){

                    _mapController=controller;
                    _mapController.setMapStyle(jsonEncode(MapStyle));
                  },
                ),
                AnimatedPositioned(
                  bottom: 0,
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
                )
                // FloatingActionButton(
                //   onPressed: () => setState(() {
                //     _click();
                //   }),
                // )
                //MapPinPillComponent(
                //  pinPillPosition: pinPillPosition,)
              ],
            )
        )
    );
  }

  void _click() {
    _isPlaying = !_isPlaying;

    if (_isPlaying) {
      _icon = Icons.stop;
      _color = Colors.grey;
      _start();
      _startTracking();
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
      _polylines.clear();
      _myRoute = List();
    });
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                            Colors.red,
                            Colors.orange
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(9.0),
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
                              "9분 31초",
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
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Colors.red,
                            Colors.orange
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(9.0),
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
                              "0.83 km",
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
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Colors.red,
                            Colors.orange
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "걸음",
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
                              "1,307",
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: Image.asset(
                        'assets/pics/result.png',
                        width: 300,
                        height: 250,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "코스 이름을 입력해 주세요",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
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
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    currentFocus.unfocus();
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
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    currentFocus.unfocus();
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
