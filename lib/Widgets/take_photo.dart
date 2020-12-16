import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/Widgets/my_progress_indicator.dart';

final cameras = availableCameras();

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {

  CameraController _controller;
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: availableCameras(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              width: 390,
              height: 390,
              color: Colors.black,
              //스냅샷이 데이터가 있으면 프리뷰를 보여주고 그렇지 않으면 프로그래스
              child: (snapshot.hasData)?_getPreview(snapshot.data):_progress,
            ),
            Expanded(
             child: OutlineButton(
               onPressed: (){},
               shape: CircleBorder(),
               borderSide: BorderSide(color: Colors.black26, width: 20),
             ),
            )
          ],
        );
      }
    );
  }

  Widget _getPreview(List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else{
          return _progress;
        }
      }
    );
  }
}
