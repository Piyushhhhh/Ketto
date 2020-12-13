import 'package:flutter/material.dart';

class UserActionOptionsWidget extends StatelessWidget {
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
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child:
                  getReactionWidget("Like", "assets/images/Likereaction.png"),
              onTap: () {},
            ),
            SizedBox(
              width: 16,
            ),
            getReactionWidget("Haha", "assets/images/Happyreaction.png"),
            SizedBox(
              width: 16,
            ),
            getReactionWidget("Sad", "assets/images/Sadreaction.png"),
          ],
        ),
      ),
    );
  }
}
