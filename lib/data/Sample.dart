
import 'package:flutter_app_map_test01/models/Collocation.dart';
import 'package:flutter_app_map_test01/models/Post.dart';
import 'package:flutter_app_map_test01/models/User.dart';


class Sample{
  static User seong_il = new User(
    name: "Seong il",
    profilePicture: "assets/pics/normal01.jpg",
    username: "@woosi",
    followers: 46,
    following: 56,
    collocation: [
      new Collocation(
          name:"Photography",
          tags: [
            "장소",
            "날씨",
            "사진"
          ],
          thumbnail: "assets/pics/one.jpg",
          posts: [
            new Post(
                location: "Taibei, Taiwan",
                dateAgo: "3 hours ago",
                photos: [
                  'assets/pics/one.jpg',
                  'assets/pics/two.jpg',
                  'assets/pics/three.jpg',
                ]
            ),
            // new Post(
            //     location: "Incheon, Korea",
            //     dateAgo: "2 month ago",
            //     photos: [
            //       'assets/pics/four.jpg',
            //       'assets/pics/five.jpg',
            //       'assets/pics/six.jpg',
            //     ]
            // )
          ]
      ),
    ],
  );

  static User hanho = new User(
    name: "Han ho",
    profilePicture: "assets/pics/hanho.jpg",
    username: "@gugu",
    followers: 78,
    following: 83,
    collocation: [
      new Collocation(
          name:"Photography",
          tags: [
            "장소",
            "날씨",
            "사진"
          ],
          thumbnail: "assets/pics/six.jpg",
          posts: [
            new Post(
                location: "seoul, Korea",
                dateAgo: "7 hours ago",
                photos: [
                  'assets/pics/five.jpg',
                  'assets/pics/six.jpg',
                  'assets/pics/seven.jpg',
                ]
            ),
            // new Post(
            //     location: "paris, France",
            //     dateAgo: "3 month ago",
            //     photos: [
            //       'assets/pics/four.jpg',
            //       'assets/pics/five.jpg',
            //       'assets/pics/six.jpg',
            //     ]
            // )
          ]
      ),
    ],
  );

  static User Sang_rok = new User(
    name: "Sang_rok",
    profilePicture: "assets/pics/Sang_rok.png",
    username: "@evergreen",
    followers: 46,
    following: 56,
    collocation: [
      new Collocation(
          name:"사진",
          tags: [
            "장소",
            "날씨",
            "사진"
          ],
          thumbnail: "assets/pics/Sang_rok01.png",
          posts: [
            new Post(
                location: "seoul, Korea",
                dateAgo: "2 days ago",
                photos: [
                  'assets/pics/Sang_rok01.png',
                  'assets/pics/Sang_rok02.png',
                  'assets/pics/Sang_rok03.png',
                ]
            ),
            new Post(
                location: "paris, France",
                dateAgo: "3 months ago",
                photos: [
                  'assets/pics/four.jpg',
                  'assets/pics/five.jpg',
                  'assets/pics/six.jpg',
                ]
            )
          ]
      ),
    ],
  );

  static User Xang_gi = new User(
    name: "Xang_gi",
    profilePicture: "assets/pics/xang_gi.png",
    username: "@Xang_qi",
    followers: 46,
    following: 56,
    collocation: [
      new Collocation(
          name:"사진",
          tags: [
            "장소",
            "날씨",
            "사진"
          ],
          thumbnail: "assets/pics/xang_gi.png",
          posts: [
            new Post(
                location: "Incheon",
                dateAgo: "2 days ago",
                photos: [
                  'assets/pics/xang_gi02.png',
                  'assets/pics/xang_rok03.png',
                ]
            ),
            new Post(
                location: "paris, France",
                dateAgo: "3 month ago",
                photos: [
                  'assets/pics/four.jpg',
                  'assets/pics/five.jpg',
                  'assets/pics/six.jpg',
                ]
            )
          ]
      ),
    ],
  );

  static Post postOne = new Post(
      user: seong_il,
      location: "Inha Univ, Incheon",
      dateAgo: "3 hours ago",
      photos: [
        'assets/pics/route (1).png',
        'assets/pics/walkie (1).jpg',
        'assets/pics/walkie (2).jpg',
        'assets/pics/walkie (3).jpg',
      ],
      relatedPhotos: [
        'assets/pics/five.jpg',
        'assets/pics/three.jpg',
        'assets/pics/two.jpg',
      ]
  );

  static Post postTwo = new Post(
      user: hanho,
      location: "Incheon",
      dateAgo: "7 hours ago",
      photos: [
        'assets/pics/route (2).png',
        'assets/pics/walkie (5).jpg',
        'assets/pics/walkie (4).jpg',
      ],
      relatedPhotos: [
        'assets/pics/seven.jpg',
        'assets/pics/eight.jpg',
        'assets/pics/one.jpg',
        'assets/pics/two.jpg',
        'assets/pics/three.jpg',
      ]
  );

  static Post postThree = new Post(
      user: Sang_rok,
      location: "Incheon",
      dateAgo: "2 days ago",
      photos: [
        'assets/pics/route (3).png',
        'assets/pics/Sang_rok03.png',
        'assets/pics/walkie (7).jpg',
        'assets/pics/walkie (8).jpg',
      ],
      relatedPhotos: [
        'assets/pics/two.jpg',
        'assets/pics/three.jpg',
        'assets/pics/five.jpg',
        'assets/pics/six.jpg',
        'assets/pics/eight.jpg',
      ]
  );

  static Post postFour = new Post(
      user: Xang_gi,
      location: "Incheon",
      dateAgo: "4 months ago",
      photos: [
        'assets/pics/route (4).png',
        'assets/pics/xang_gi02.png',
        'assets/pics/xang_gi03.png',
      ],
      relatedPhotos: [
        'assets/pics/two.jpg',
        'assets/pics/three.jpg',
        'assets/pics/five.jpg',
        'assets/pics/six.jpg',
        'assets/pics/eight.jpg',
      ]
  );
}