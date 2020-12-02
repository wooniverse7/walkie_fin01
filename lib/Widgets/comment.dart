import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/constants/common_size.dart';
import 'Rounded_avatar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String username;
  final String text;
  final DateTime dateTime;

  Comment({
    //@required 코딩할 때 필요
    Key key,
    this.showImage = true,
    @required this.username,
    @required this.text,
    this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showImage) RoundedAvatar(size: 24),
        if (showImage)
          SizedBox(
            width: common_xxs_gap,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    //TextSpan은 primarySwatch:white를 따라간다.
                      text: username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87)),
                  TextSpan(text: '  '),
                  TextSpan(text: text, style: TextStyle(color: Colors.black87)),
                ])),
            //dateTime이 있으면 Text를 보여주어라.
            if (dateTime != null)
              Text(dateTime.toIso8601String(),
                  style: TextStyle(color: Colors.grey[400]))
          ],
        ),
      ],
    );
  }
}
