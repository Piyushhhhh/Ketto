import 'package:flutter/material.dart';

class UserActionOptionsWidget extends StatefulWidget {
  @override
  _UserActionOptionsWidgetState createState() =>
      _UserActionOptionsWidgetState();
}

class _UserActionOptionsWidgetState extends State<UserActionOptionsWidget> {
  bool showDialog = true;

  Row getReactionWidget(String text, String iconPath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          iconPath,
          height: 24,
          width: 24,
        ),
        SizedBox(
          width: 8,
        ),
        Text(text)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return showDialog
        ? GestureDetector(
            onTap: () {
              setState(() {
                showDialog = false;
              });
            },
            child: Dialog(
              elevation: 0.7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    getReactionWidget("Like", "assets/images/Likereaction.png"),
                    SizedBox(
                      width: 16,
                    ),
                    getReactionWidget(
                        "Haha", "assets/images/Happyreaction.png"),
                    SizedBox(
                      width: 16,
                    ),
                    getReactionWidget("Sad", "assets/images/Sadreaction.png"),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
