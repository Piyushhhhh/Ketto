import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kettotask/bloc/overlays/bloc.dart';
import 'package:kettotask/bloc/overlays/event.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/delegates/action_delegate.dart';
import 'package:kettotask/delegates/date_delegate.dart';
import 'package:kettotask/model/event.dart';
import 'package:kettotask/ui/feed/widgets/event_ask_widget.dart';
import 'package:kettotask/ui/feed/widgets/event_location_widget.dart';
import 'package:kettotask/ui/feed/widgets/post_hashtags_widget.dart';
import 'package:kettotask/ui/feed/widgets/post_user_widget.dart';
import 'package:kettotask/ui/feed/widgets/user_action_bar_widget.dart';
import 'package:kettotask/ui/feed/widgets/user_action_options_widget.dart';
import 'package:kettotask/ui/feed/widgets/user_reaction_model_widget.dart';

class EventWidgetItem extends StatefulWidget {
  final EventModel eventModel;

  EventWidgetItem(this.eventModel);

  @override
  _EventWidgetItemState createState() => _EventWidgetItemState();
}

class _EventWidgetItemState extends State<EventWidgetItem> {
  void onMenuTap() {
    ActionDelegate.showPostBottomModal(widget.eventModel, context);
  }

  void showShareAction() {
    ActionDelegate.showShareBottomModal(widget.eventModel, context);
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
      ..add(AddOverLay(widget.eventModel.type, reactionOverlay, ctx));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.eventModel.tag.toUpperCase(),
                      style: commonTextStyles.postItemTagText,
                    ),
                    Text(
                      '1min',
                      style: commonTextStyles.postItemTime,
                    )
                  ],
                ),
                PostUserWidget(
                  widget.eventModel.postCreator,
                  onMenuTap,
                  hasCreatedEvent: true,
                ),
                Text(
                  widget.eventModel.description,
                  style: commonTextStyles.postItemTitleText,
                ),
                if (widget.eventModel.hashTags?.isNotEmpty ?? false)
                  SizedBox(
                    height: 4,
                  ),
                PostHashTagWidget(widget.eventModel.hashTags),
                SizedBox(
                  height: 8,
                ),
                Text(
                  DateDelegate.getDateForEventItem(widget.eventModel.eventTime)
                      .toUpperCase(),
                  style: commonTextStyles.eventDateText,
                ),
                SizedBox(
                  height: 8,
                ),
                EventLocationWidget(widget.eventModel.address),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          EventAskWidget(widget.eventModel.acceptedUsers),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                UserReactionWidget(
                  widget.eventModel.likes.map((e) => e.user).toList(),
                  showLike: true,
                ),
                Divider(),
                SizedBox(
                  height: 4,
                ),
                UserActionBarWidget(
                  widget.eventModel.comments.length,
                  showUserActions,
                  showShareAction,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
