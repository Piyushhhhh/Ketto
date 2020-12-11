import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kettotask/bloc/overlays/bloc.dart';
import 'package:kettotask/bloc/overlays/event.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/delegates/action_delegate.dart';
import 'package:kettotask/interfaces/post_interface.dart';
import 'package:kettotask/model/post.dart';
import 'package:kettotask/ui/feed/widgets/post_hashtags_widget.dart';
import 'package:kettotask/ui/feed/widgets/post_location_widget.dart';
import 'package:kettotask/ui/feed/widgets/post_user_widget.dart';
import 'package:kettotask/ui/feed/widgets/user_action_bar_widget.dart';
import 'package:kettotask/ui/feed/widgets/user_action_options_widget.dart';
import 'package:kettotask/ui/feed/widgets/user_reaction_model_widget.dart';

class PostItemWidget extends StatefulWidget {
  final PostModel postModel;
  final Function(PostInterface) onItemTap;

  PostItemWidget(this.postModel, {this.onItemTap});

  @override
  _PostItemWidgetState createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  var _maxLine = 3;
  bool seeMoreClicked = false;

  Widget expandedText(String text) {
    var exceeded;
    return LayoutBuilder(builder: (context, size) {
      // Build the textspan
      var span = TextSpan(
        text: text,
        style: commonTextStyles.postItemSubTitleText,
      );

      // Use a textpainter to determine if it will exceed max lines
      var tp = TextPainter(
        maxLines: _maxLine.toInt(),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        text: span,
      );

      // trigger it to layout
      tp.layout(maxWidth: size.maxWidth);

      // whether the text overflowed or not
      exceeded = tp.didExceedMaxLines;

      // return Column(children: <Widget>[
      return Container(
        child: exceeded && seeMoreClicked
            ? _seeMoreLess(span, "See Less ")
            : exceeded && !seeMoreClicked
                ? _seeMoreLess(span, "See More", 3)
                : Text.rich(
                    span,
                    style: commonTextStyles.postItemSubTitleText,
                    overflow: TextOverflow.visible,
                  ),
      );
    });
  }

  Widget _seeMoreLess(TextSpan span, String _text, [int maxLine = 0]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        maxLine > 0
            ? Text.rich(
                span,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: commonTextStyles.postItemSubTitleText,
              )
            : Text.rich(
                span,
                overflow: TextOverflow.visible,
                style: commonTextStyles.postItemSubTitleText,
              ),
        InkWell(
            child: Text(
              _text,
              style: commonTextStyles.postItemSeeMoreText,
            ),
            onTap: () {
              setState(() {
                seeMoreClicked = !seeMoreClicked;
              });
            }),
      ],
    );
  }

  void onMenuTap() {
    ActionDelegate.showPostBottomModal(widget.postModel, context);
  }

  void showShareAction() {
    ActionDelegate.showShareBottomModal(widget.postModel, context);
  }

  void showUserActions(GlobalKey key) {
    BuildContext ctx = key.currentContext;
    Widget childToShow = UserActionOptionsWidget();
    RenderBox renderBox = ctx.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var center = Offset(
        offset.dx + size.width / 2 - 15, offset.dy + size.height / 2 - 15);
    OverlayEntry reactionOverlay = OverlayEntry(
        builder: (context) => Positioned(
              left: center.dx - size.width / 2 - 16,
              top: center.dy - size.height / 2 - 8 - 45,
              child: childToShow,
            ));
    Overlay.of(context).insert(reactionOverlay);
//    widget.overlayEntries.add(reactionOverlay);
    BlocProvider.of<OverLayBloc>(context)
      ..add(AddOverLay(widget.postModel.type, reactionOverlay, ctx));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.postModel.tag.toUpperCase(),
                style: commonTextStyles.postItemTagText,
              ),
              Text(
                '1min',
                style: commonTextStyles.postItemTime,
              )
            ],
          ),
          PostUserWidget(widget.postModel.postCreator, onMenuTap,
              hasAskedQuestion: widget.postModel.isQuestion),
          GestureDetector(
            onTap: () {
              if (widget.onItemTap != null) widget.onItemTap(widget.postModel);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.postModel.title?.isNotEmpty ?? false)
                  Text(
                    widget.postModel.title,
                    style: commonTextStyles.postItemTitleText,
                  ),
                if (widget.postModel.title?.isNotEmpty ?? false)
                  SizedBox(
                    height: 8,
                  ),
                if (widget.postModel.subTitle?.isNotEmpty ?? false)
                  expandedText(widget.postModel.subTitle),
                if (widget.postModel.hashTags?.isNotEmpty ?? false)
                  SizedBox(
                    height: 4,
                  ),
                PostHashTagWidget(widget.postModel?.hashTags),
                if (widget.postModel.subTitle?.isNotEmpty ?? false)
                  SizedBox(
                    height: 8,
                  ),
                if (widget.postModel.image?.isNotEmpty ?? false)
                  if (widget.postModel.image.startsWith("http"))
                    CachedNetworkImage(
                      imageUrl: widget.postModel.image,
                    )
                  else
                    Image.asset(widget.postModel.image),
                if (widget.postModel.image?.isNotEmpty ?? false)
                  SizedBox(
                    height: 8,
                  ),
                PostLocationWidget(widget.postModel.address),
                Divider(),
                UserReactionWidget(
                  widget.postModel.usersHaveSameQuestion,
                  showQuestionAsked: widget.postModel.isQuestion,
                  showReaction: !widget.postModel.isQuestion,
                  hasUserCommented: widget.postModel.comments
                      .where((each) => each.user.id == 1)
                      .toList()
                      .isNotEmpty,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(),
          UserActionBarWidget(
            widget.postModel.comments.length,
            showUserActions,
            showShareAction,
            hasUserCommented: widget.postModel.comments
                .where((each) => each.user.id == 1)
                .toList()
                .isNotEmpty,
            isQuestion: widget.postModel.isQuestion,
          )
        ],
      ),
    );
  }
}
