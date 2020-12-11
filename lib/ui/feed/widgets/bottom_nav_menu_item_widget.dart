import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/bottom_nav_menu_item.dart';

class BottomNavMenuItemWidget extends StatelessWidget {
  final BottomNavMenuItemModel model;

  BottomNavMenuItemWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 16,
          child: Icon(
            model.iconData,
            color: themes.primaryColor,
            size: 16,
          ),
          backgroundColor: themes.bGPrimaryColor,
        ),
        title: Text(
          model.title,
          style: commonTextStyles.postAddButtonBottomNavTitleText,
        ),
        subtitle: Text(
          model.subtitle,
          style: commonTextStyles.postAddButtonBottomNavSubTitleText,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: themes.secondaryBlack,
        ),
      ),
    );
  }
}
