import 'package:flutter/material.dart';
import 'package:kettotask/utils/text_style_type.dart';

class UserActionBarWidget extends StatelessWidget {
  final void Function(GlobalKey) showUserActions;
  final bool isQuestion;
  final Function showShareBottomModal;
  final bool hasUserCommented;
  final int commentPostNum;

  UserActionBarWidget(
      this.commentPostNum, this.showUserActions, this.showShareBottomModal,
      {this.isQuestion = false, this.hasUserCommented = false});

  @override
  Widget build(BuildContext context) {
    GlobalKey reactionRowKey;
    reactionRowKey = GlobalKey();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: () {
              showUserActions(reactionRowKey);
            },
            child: Row(
              key: reactionRowKey,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  isQuestion
                      ? hasUserCommented
                          ? 'assets/images/question.png'
                          : 'assets/images/empty_questionuser.png'
                      : 'assets/images/empty_likeuser_like.png',
                  width: 24,
                  height: 24,
                ),
                Text(
                  '$commentPostNum',
                  style: commonTextStyles.postUserReactionNumberText,
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //assets/images/Shapecomment.png
              Image.asset(
                'assets/images/comment-linescomment.png',
                width: 24,
                height: 24,
              ),
              Text(
                '24',
                style: commonTextStyles.postUserReactionNumberText,
              )
            ],
          ),
          Icon(Icons.turned_in_not),
          GestureDetector(
            onTap: () {
              showShareBottomModal();
            },
            child: Image.asset(
              "assets/images/share.png",
              height: 16,
              width: 16,
            ),
          )
        ],
      ),
    );
  }
}
