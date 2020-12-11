import 'package:flutter/material.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/address.dart';

class EventLocationWidget extends StatelessWidget {
  final AddressModel addressModel;

  EventLocationWidget(this.addressModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.place,
          color: Colors.grey,
          size: 24,
        ),
        SizedBox(
          width: 6,
        ),
        RichText(
          text: TextSpan(
              text: addressModel.apartment,
              style: commonTextStyles.eventLocationText,
              children: [
                TextSpan(text: ", "),
                TextSpan(text: addressModel.area),
                TextSpan(text: ", "),
                TextSpan(text: addressModel.city),
              ]),
        ),
      ],
    );
  }
}
