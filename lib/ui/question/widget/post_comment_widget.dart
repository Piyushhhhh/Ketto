import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/comment.dart';
import 'package:kettotask/ui/question/widget/comment_user_widget.dart';
import 'package:kettotask/ui/question/widget/post_comment_reply_by_current_user.dart';

class PostCommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  PostCommentWidget(this.commentModel);

  @override
  Widget build(BuildContext context) {
    if (commentModel.user.id == 1)
      return PostCommentReplyByCurrentUser(commentModel);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            maxRadius: 12,
            child: CachedNetworkImage(
              imageUrl: commentModel.user.userProfileURL,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: themes.secondaryGrey),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommentUserWidget(commentModel.user, null),
                  SizedBox(
                    height: 8,
                  ),
                  Text(commentModel.comment),
                  SizedBox(
                    height: 16,
                  ),
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
                          Image.asset(
                            "assets/images/Upvote.png",
                            height: 16,
                            width: 16,
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
                          Image.asset(
                            "assets/images/Downvote.png",
                            height: 16,
                            width: 16,
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
                      IntrinsicHeight(
                        child: Row(
                          children: <Widget>[
                            VerticalDivider(),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Reply',
                              style: commonTextStyles.commentReplyText,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: Text(
                      '2 replies',
                      style: commonTextStyles.commentReplyCountText,
                    ),
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
