import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/user.dart';

class UserReactionWidget extends StatelessWidget {
  final List<UserModel> reactedUser;
  final bool showLike;
  final bool showQuestionAsked;
  final bool showReaction;
  final bool isEvent;
  final bool isPost;
  final hasUserCommented;

  UserReactionWidget(this.reactedUser,
      {this.hasUserCommented = false,
      this.showLike = false,
      this.showQuestionAsked = false,
      this.showReaction = false,
      this.isEvent = false,
      this.isPost = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 0, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (reactedUser != null && reactedUser.isNotEmpty)
            SizedBox(
              height: 24,
              width: reactedUser.length * 16.0,
              child: Stack(
                children: <Widget>[
                  if (reactedUser.length > 1)
                    Positioned(
                        left: 0,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    reactedUser[0].userProfileURL,
                                  ))),
                        )),
                  if (reactedUser.length > 2)
                    Positioned(
                        left: 16,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                reactedUser[1].userProfileURL,
                              ))),
                        )),
                  if (reactedUser.length > 3)
                    Positioned(
                        left: 32,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                reactedUser[2].userProfileURL,
                              ))),
                        )),
                ],
              ),
            ),
          Text(
            "${hasUserCommented ? 'You and ${reactedUser.length - 1} others' : '${reactedUser.length} members'} ${showQuestionAsked ? 'have this question' : showLike ? 'likes this' : showReaction ? 'reacted to this' : ''} ${isPost ? 'post' : isEvent ? 'event' : ''}",
            style: commonTextStyles.postUserListText,
          )
        ],
      ),
    );
  }
}
