import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/address.dart';

class PostLocationWidget extends StatelessWidget {
  final AddressModel addressModel;

  PostLocationWidget(this.addressModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.place,
          color: themes.primaryColor,
          size: 16,
        ),
        SizedBox(
          width: 6,
        ),
        RichText(
          text: TextSpan(
              text: addressModel.apartment,
              style: commonTextStyles.postLocationText,
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
