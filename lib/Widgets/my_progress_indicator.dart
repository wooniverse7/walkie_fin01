import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {

  //final은 initailize필요
  final double containalSize;
  final double progressSize;

  const MyProgressIndicator({Key key, this.containalSize, this.progressSize=60}) : super(key: key);//유동적 사이즈를 위해

  @override
  Widget build(BuildContext context) {
    return Container(
        width:containalSize,
        height:containalSize,
        child: Center(
            child: SizedBox(
                height: progressSize,
                width: progressSize,
                child: Image.asset('assets/images/loading02.gif')
            )));
    ;
  }
}
