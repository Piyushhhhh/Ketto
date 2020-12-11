import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/comment.dart';

class PostCommentReplyByCurrentUser extends StatelessWidget {
  final CommentModel commentModel;

  PostCommentReplyByCurrentUser(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: themes.commentInputBgColor,
                  border: Border.all(color: themes.secondaryGrey),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(commentModel.comment),
                  SizedBox(
                    height: 16,
                  ),
                  if (commentModel.images != null &&
                      commentModel.images.isNotEmpty)
                    Center(
                      child: CachedNetworkImage(
                        height: MediaQuery.of(context).size.height * 0.2,
                        imageUrl: commentModel.user.userProfileURL,
                      ),
                    ),
                  Divider(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_upward,
                            color: themes.primaryColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '10',
                            style: commonTextStyles.commentUpVoteText,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '4',
                            style: commonTextStyles.commentDownVoteText,
                          )
                        ],
                      ),
                      Image.asset(
                        "assets/images/share.png",
                        height: 16,
                        width: 16,
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          CircleAvatar(
            maxRadius: 12,
            child: CachedNetworkImage(
              imageUrl: commentModel.user.userProfileURL,
            ),
          ),
        ],
      ),
    );
  }
}
