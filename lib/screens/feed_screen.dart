import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/models/Post.dart';
import 'package:flutter_app_map_test01/data/Sample.dart';
import 'package:flutter_app_map_test01/heiper/Colorsys.dart';
import 'package:flutter_app_map_test01/pages/SingleUser.dart';

class FeedScreen extends StatefulWidget {

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( //StatefullWidget의 기능 사용허가
      backgroundColor: Colorsys.lightGrey,
      appBar: AppBar(
          elevation : 0,
          backgroundColor: Colorsys.lightGrey,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colorsys.darkGrey,),
          )
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              searchBox(),
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("For you", style: TextStyle(
                        color: Colorsys.darkGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Colorsys.lightGrey
                          ))
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Recommend", style: TextStyle(
                                    color: Colorsys.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                                Container(
                                  width: 50,
                                  padding: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colorsys.orange,
                                          width: 3
                                      ))
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 20,),
                            Text("Likes", style: TextStyle(
                                color: Colorsys.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            ))
                          ]
                      ),
                    ),
                    SizedBox(height: 30,),
                    makePost(Sample.postOne),
                    makePost(Sample.postTwo),
                    makePost(Sample.postThree),
                    makePost(Sample.postFour),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Widget makePost(Post post){
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SingleUser(user: post.user)
                ));
              },
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 20,
                    backgroundImage: AssetImage(post.user.profilePicture),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.user.name, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(post.location, style: TextStyle(
                                fontSize: 13,
                                color: Colorsys.grey
                            ),),
                            Text(post.dateAgo, style: TextStyle(
                                fontSize: 13,
                                color: Colorsys.grey
                            ),)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 300,
                padding: EdgeInsets.only(top: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.photos.length,
                  itemBuilder: (context, index){
                    return AspectRatio(
                      aspectRatio: 1.2/1,
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(post.photos[index]),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children:[
                                            // ClipRect(
                                            //   child: BackdropFilter(
                                            //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                            //       child: Container(
                                            //         width: 30.0,
                                            //         height: 30.0,
                                            //         padding: EdgeInsets.all(5),
                                            //         decoration: BoxDecoration(
                                            //             borderRadius: BorderRadius.circular(4),
                                            //             color: Colors.grey[600].withOpacity(0.1)
                                            //         ),
                                            //         child: Center(
                                            //             child: Image.asset('assets/images/link01.png')
                                            //         ),
                                            //       )
                                            //   ),
                                            // ),
                                            SizedBox(width: 10,),
                                            ClipRect(
                                              child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                  child: Container(
                                                    width: 30.0,
                                                    height: 30.0,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        color: Colors.grey[600].withOpacity(0.1)
                                                    ),
                                                    child: Center(
                                                        child: Image.asset('assets/images/heart.png')
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ]
                                      )
                                  )
                              )
                            ],
                          )
                      ),
                    );
                  },
                )
            )
          ],
        )
    );
  }

  Widget searchBox(){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Text("숨겨져있던 산책길을 \n찾아보세요!", style: TextStyle(
                fontSize: 22,
                color: Colorsys.darkGrey,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 30,),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20, right: 3, top: 3, bottom: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "검색",
                          hintStyle: TextStyle(color: Colorsys.grey),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    height: double.infinity,
                    minWidth: 50,
                    elevation: 0,
                    color: Colorsys.orange,
                    child: Icon(Icons.search, color: Colors.white,),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}


// class FeedScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( //StatefullWidget의 기능 사용허가
//       appBar: CupertinoNavigationBar(
//           leading: IconButton(
//               onPressed: null,
//               icon:Icon(CupertinoIcons.map, color: Colors.black87)
//           ),
//           middle: Text(
//             'Feed',
//             style: TextStyle(fontFamily: 'veganStyle', color: Colors.black87,),
//           ),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               IconButton(
//                   onPressed: null,
//                   icon: ImageIcon(
//                       AssetImage('assets/images/star01.png'),
//                       color: Colors.black87
//                   )
//               )
//             ],
//           )
//       ),
//       body: ListView.builder(itemBuilder: feedListBuilder, itemCount: 30,),
//     );
//   }
//   Widget feedListBuilder(BuildContext context, int index){
//     return Post(index);
//   }
// }



