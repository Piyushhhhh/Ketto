import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/user.dart';
import 'package:kettotask/ui/feed/widgets/event_ask_button_widget.dart';

class EventAskWidget extends StatelessWidget {
  final List<UserModel> acceptedUsers;

  EventAskWidget(this.acceptedUsers);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: themes.bGPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Are you going ?',
                style: commonTextStyles.eventAskQuestionText,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    "assets/images/ShapeeventPeople.png",
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '21 People Going',
                    style: commonTextStyles.eventAskQuestionStatusText,
                  )
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              EventAskButtonWidget('No', () {
                print('no');
              }),
              SizedBox(
                width: 16,
              ),
              EventAskButtonWidget('Yes', () {
                print('yes');
              }),
            ],
          )
        ],
      ),
    );
  }
}
