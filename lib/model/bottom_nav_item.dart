import 'package:flutter/cupertino.dart';

class BottomNavItemModel {
  String image;
  String text;
  bool haveNotification;
  Function onTap;
  bool isCenter;
  ValueNotifier valueNotifier;
  String secondImage;

  BottomNavItemModel(this.image, this.text, this.onTap,
      {this.haveNotification,
      this.isCenter = false,
      this.valueNotifier,
      this.secondImage});
}
