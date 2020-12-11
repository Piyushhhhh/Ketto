import 'package:flutter/cupertino.dart';

class BottomNavMenuItemModel {
  IconData iconData;
  String title;
  String subtitle;
  Function onTap;

  BottomNavMenuItemModel(this.iconData, this.title, this.subtitle, this.onTap);
}
