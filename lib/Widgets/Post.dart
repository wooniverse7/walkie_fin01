import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/Widgets/Rounded_avatar.dart';
import 'package:flutter_app_map_test01/Widgets/comment.dart';
import 'package:flutter_app_map_test01/Widgets/my_progress_indicator.dart';
import 'package:flutter_app_map_test01/constants/common_size.dart';

class Post extends StatelessWidget {
  final int index;
  Size size;

  //this를 이용해 값을 받아오자마자 위에 넣어준다.
  Post(this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery
        .of(context)
        .size; //사용하는 디바이스 화면 size

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postheader(),
        _postImage(),
        _postActions(), //마지막에 ,를 입력 후 ctrl+alt+L을 누르면 자동 정렬
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: false,
        username: 'testingUser',
        text: 'i have patient',
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text('12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }

  Row _postActions() {
    return Row(
      children: [
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/comment.png')),
          color: Colors.black87,
        ),
        // IconButton(
        //   onPressed: null,
        //   icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
        //   color: Colors.black87,
        // ),
        Spacer(), //3개 버튼과 공백 추가
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget _postheader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(), //make avatar widget
        ),
        Expanded(child: Text('username')),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      placeholder: (BuildContext context,
          String url,) {
        return MyProgressIndicator(
          containalSize: size.width,
        );
      },
      imageBuilder: (BuildContext context, ImageProvider imageprovider) {
        return AspectRatio(
          aspectRatio: 1, //image 비율 1
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageprovider, fit: BoxFit.fitHeight)),
          ),
        );
      },
    );
  }
}

