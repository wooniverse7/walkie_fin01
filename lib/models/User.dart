import 'package:flutter_app_map_test01/models/Collocation.dart';

class User{
  final String name;
  final String profilePicture;
  final String username;
  final int followers;
  final int following;
  final List<Collocation> collocation;

  User({this.name, this.profilePicture, this.username, this.followers, this.following, this.collocation});

}