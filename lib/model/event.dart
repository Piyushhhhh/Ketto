import 'package:kettotask/interfaces/post_interface.dart';
import 'package:kettotask/model/address.dart';
import 'package:kettotask/model/comment.dart';
import 'package:kettotask/model/like.dart';
import 'package:kettotask/model/user.dart';

class EventModel extends PostInterface {
  final List<UserModel> acceptedUsers;
  final String description;
  final DateTime eventTime;

  EventModel(
      this.acceptedUsers,
      this.description,
      this.eventTime,
      UserModel eventCreator,
      String tag,
      DateTime postedTime,
      String title,
      String subTitle,
      AddressModel address,
      List<LikeModel> likes,
      List<CommentModel> comments,
      bool isSaved,
      {hashTags})
      : super(PostInterface.eventType, eventCreator, tag, postedTime, title,
            subTitle, address, likes, comments, isSaved, hashTags);
}
