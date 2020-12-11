import 'package:flutter/material.dart';
import 'package:kettotask/utils/theme.dart';

class CommonTextStyles {
  TextStyle loginPageTitle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 40, color: Color(0xff545B63));

  TextStyle loginPageInfo = TextStyle(
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Colors.black26,
      fontSize: 14);

  TextStyle loginPageOTPButtonDisabled =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20);

  TextStyle loginPageOTPButtonEnabled =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);

  TextStyle homeFeedSubTitleText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      letterSpacing: 1.3);
  TextStyle homePostFieldHintText = TextStyle(fontSize: 16, color: Colors.grey);

  TextStyle homeFeedTitleText = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: themes.primaryColor);

  TextStyle postUserItemIdText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle postUserItemSubTitle = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w400, color: themes.primaryColor);
  TextStyle postItemTagText =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey);
  TextStyle postItemTime = TextStyle(fontSize: 12, color: themes.postTimeColor);

  TextStyle postItemUserQuestionStatusText =
      TextStyle(fontSize: 14, color: Colors.grey);
  TextStyle postItemTitleText =
      TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle postItemSeeMoreText = TextStyle(
      fontSize: 14, color: themes.seeMoreColor, fontWeight: FontWeight.bold);
  TextStyle postItemSubTitleText = TextStyle(
      fontSize: 15,
      color: themes.secondaryBlack,
      fontWeight: FontWeight.normal);
  TextStyle postLocationText =
      TextStyle(color: themes.primaryColor, fontSize: 12);
  TextStyle eventLocationText = TextStyle(color: Colors.grey, fontSize: 14);
  TextStyle postUserListText =
      TextStyle(fontSize: 12, color: themes.postUserListColor);
  TextStyle postUserReactionNumberText = TextStyle(
      fontSize: 14,
      color: themes.postUserListColor,
      fontWeight: FontWeight.bold);
  TextStyle eventAskButtonText =
      TextStyle(fontSize: 14, color: themes.primaryColor);
  TextStyle eventAskQuestionText =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle eventAskQuestionStatusText =
      TextStyle(fontSize: 12, color: themes.secondaryBlack);
  TextStyle eventDateText =
      TextStyle(fontSize: 13, color: themes.secondaryBlack);
  TextStyle hashTagsText =
      TextStyle(fontSize: 14, color: themes.hashTagTextColor);
  TextStyle userTagText = TextStyle(
      fontSize: 11, fontWeight: FontWeight.bold, color: themes.primaryColor);
  TextStyle userTitleText = TextStyle(fontSize: 12, color: themes.primaryColor);
  TextStyle articleItemUserNameText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle readArticleItemText = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: themes.primaryColor);
  TextStyle articleListTitle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: themes.secondaryBlack);
  TextStyle bottomNavTextSelected =
      TextStyle(fontSize: 12, color: themes.secondaryBlack);
  TextStyle bottomNavTextNotSelected =
      TextStyle(fontSize: 12, color: themes.secondaryBlack);
  TextStyle postAddButtonBottomNavTitleText =
      TextStyle(color: themes.primaryColor, fontSize: 16);
  TextStyle postAddButtonBottomNavSubTitleText = TextStyle(
    color: themes.secondaryGrey,
    fontSize: 11,
  );
  TextStyle postBottomModalTitleText = TextStyle(
    color: Color(0xff545B63),
    fontSize: 16,
  );
  TextStyle postBottomModalSubTitleText = TextStyle(
    color: themes.secondaryGrey,
    fontSize: 12,
  );

  TextStyle bottomModalShareText = TextStyle(
      color: themes.secondaryBlack, fontSize: 14, fontWeight: FontWeight.bold);

  TextStyle commentUpVoteText = TextStyle(
      color: themes.primaryColor, fontWeight: FontWeight.bold, fontSize: 14);
  TextStyle commentDownVoteText =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14);

  TextStyle commentReplyText = TextStyle(
      color: themes.primaryColor, fontWeight: FontWeight.bold, fontSize: 14);
  TextStyle commentReplyCountText =
      TextStyle(color: themes.primaryColor, fontSize: 14);
  TextStyle commentPostActionText = TextStyle(
      color: themes.primaryColor, fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle appBarText =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black);
}

CommonTextStyles commonTextStyles = CommonTextStyles();
