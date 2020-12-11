import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/post.dart';
import 'package:kettotask/ui/feed/widgets/post_item.dart';
import 'package:kettotask/ui/question/widget/post_comment_widget.dart';

class DetailsPage extends StatefulWidget {
  final PostModel postInterface;

  DetailsPage(this.postInterface);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.postInterface.isQuestion
              ? 'Question'
              : widget.postInterface.type.toUpperCase(),
          style: commonTextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  PostItemWidget(
                    widget.postInterface,
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => PostCommentWidget(
                          widget.postInterface.comments[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 12,
                          ),
                      itemCount: widget.postInterface.comments.length)
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            decoration: BoxDecoration(
                color: themes.commentInputBgColor,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            margin: EdgeInsets.only(left: 8, right: 16, bottom: 16, top: 8),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add a cheerful comment....',
                border: InputBorder.none,
                suffix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        print('post');
                      },
                      child: Text(
                        'Post',
                        style: commonTextStyles.commentPostActionText,
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
