import 'package:kettotask/model/address.dart';
import 'package:kettotask/model/comment.dart';
import 'package:kettotask/model/like.dart';
import 'package:kettotask/model/user.dart';

abstract class PostInterface {
  final UserModel postCreator;
  final String tag;
  final DateTime postedTime;
  final String title;
  final String subTitle;
  final AddressModel address;
  final List<LikeModel> likes;
  final List<CommentModel> comments;
  final bool isSaved;
  static final String postType = 'post';
  static final String eventType = 'event';
  final String type;
  final List<String> hashTags;

  PostInterface(
      this.type,
      this.postCreator,
      this.tag,
      this.postedTime,
      this.title,
      this.subTitle,
      this.address,
      this.likes,
      this.comments,
      this.isSaved,
      this.hashTags);
}
