import 'package:flutter_app_map_test01/models/User.dart';

class Post{
  final User user;
  final String location;
  final String dateAgo;
  final List<String> photos;
  final List<String> relatedPhotos;

  Post({this.location, this.dateAgo, this.photos, this.relatedPhotos, this.user});
}