import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/interfaces/post_interface.dart';
import 'package:kettotask/ui/feed/widgets/post_bottom_modal_item_widget.dart';

class ActionDelegate {
  static showPostBottomModal(
      PostInterface postInterface, BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12, bottom: 16),
                  color: themes.secondaryGrey,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 5,
                ),
              ),
              PostBottomModelItemWidget(
                postInterface,
                "Hide ${postInterface.type}",
                "See fewer posts like this",
                FontAwesomeIcons.eyeSlash,
                () {},
              ),
              PostBottomModelItemWidget(
                postInterface,
                "Unfollow ${postInterface.postCreator.name}",
                "See fewer posts like this",
                FontAwesomeIcons.userPlus,
                () {},
              ),
              PostBottomModelItemWidget(
                postInterface,
                "Report ${postInterface.type}",
                "See fewer posts like this",
                FontAwesomeIcons.infoCircle,
                () {},
              ),
              PostBottomModelItemWidget(
                postInterface,
                "Copy ${postInterface.type} link",
                "See fewer posts like this",
                FontAwesomeIcons.link,
                () {},
                hideBottomBorder: true,
              )
            ],
          );
        },
        context: context);
  }

  static showShareBottomModal(
      PostInterface postInterface, BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: themes.secondaryGrey,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    margin: EdgeInsets.only(top: 0, bottom: 16),
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 4,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, bottom: 16),
                    child: Text(
                      'Share Post',
                      style: commonTextStyles.bottomModalShareText,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                        maxRadius: 22,
                        backgroundColor: themes.bGPrimaryColor,
                        child: Icon(
                          Icons.send,
                          size: 20,
                          color: themes.primaryColor,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Send as a private message')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                        maxRadius: 22,
                        backgroundColor: themes.bGPrimaryColor,
                        child: Image.asset(
                          "assets/images/Feedfeed.png",
                          height: 20,
                          width: 20,
                          color: themes.primaryColor,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Share as a post')
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                        maxRadius: 22,
                        backgroundColor: themes.shareActionAppBGColor,
                        child: Icon(
                          FontAwesomeIcons.facebookSquare,
                          size: 20,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Share on Facebook')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                        backgroundColor: themes.shareActionAppBGColor,
                        maxRadius: 22,
                        child: Icon(
                          FontAwesomeIcons.whatsappSquare,
                          size: 20,
                          color: themes.whatsAppIconColor,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Send via WhatsApp')
                  ],
                ),
              ],
            ),
          );
        },
        context: context);
  }
}
