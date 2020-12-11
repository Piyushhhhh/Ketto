import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';

class EventAskButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;

  EventAskButtonWidget(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: themes.bGPrimaryColor,
      shape: StadiumBorder(),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        focusColor: themes.secondaryPrimaryColor,
        highlightColor: themes.secondaryPrimaryColor,
        splashColor: themes.secondaryPrimaryColor,
        hoverColor: themes.secondaryPrimaryColor,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: themes.secondaryPrimaryColor),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Text(
            text,
            style: commonTextStyles.eventAskButtonText,
          ),
        ),
      ),
    );
  }
}
