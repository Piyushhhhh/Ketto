import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/user.dart';

class CommentUserWidget extends StatelessWidget {
  final UserModel user;
  final bool hasAskedQuestion;
  final bool hasCreatedEvent;
  final Function onMenuTap;

  CommentUserWidget(this.user, this.onMenuTap,
      {this.hasAskedQuestion = false, this.hasCreatedEvent = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.userId,
                  style: commonTextStyles.postUserItemIdText,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('.'),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '1min',
                  style: commonTextStyles.postItemTime,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    hasAskedQuestion
                        ? 'asked a question'
                        : hasCreatedEvent
                            ? 'created an event'
                            : '',
                    style: commonTextStyles.postItemUserQuestionStatusText,
                  ),
                )
              ],
            ),
            user.tag != null
                ? IntrinsicHeight(
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: themes.bGPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/Vectorexpert.png",
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                user.tag,
                                style: commonTextStyles.userTagText,
                              ),
                            ],
                          ),
                        ),
                        if (user.title != null)
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 4,
                              ),
                              VerticalDivider(),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                user.title,
                                style: commonTextStyles.userTitleText,
                              ),
                            ],
                          )
                      ],
                    ),
                  )
                : Text(
                    'DIAGNOSED RECENTLY',
                    style: commonTextStyles.postUserItemSubTitle,
                  )
          ],
        ),
        Spacer(),
        InkWell(
          onTap: onMenuTap,
          child: Icon(
            Icons.more_vert,
            size: 28,
            color: themes.moreIconColor,
          ),
        )
      ],
    );
  }
}
