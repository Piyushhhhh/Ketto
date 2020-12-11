import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/interfaces/post_interface.dart';

class PostBottomModelItemWidget extends StatelessWidget {
  final PostInterface post;
  final bool hideBottomBorder;
  final IconData icon;
  final String title;
  final String subTitle;
  final Function onTap;

  PostBottomModelItemWidget(
      this.post, this.title, this.subTitle, this.icon, this.onTap,
      {this.hideBottomBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: themes.primaryColor,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: hideBottomBorder
                          ? BorderSide.none
                          : BorderSide(color: Colors.grey, width: 0.3))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: commonTextStyles.postBottomModalTitleText,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    subTitle,
                    style: commonTextStyles.postBottomModalSubTitleText,
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
