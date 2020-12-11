import 'package:kettotask/interfaces/post_interface.dart';
import 'package:kettotask/model/address.dart';
import 'package:kettotask/model/comment.dart';
import 'package:kettotask/model/like.dart';
import 'package:kettotask/model/user.dart';

class PostModel extends PostInterface {
  final bool isQuestion;
  final List<UserModel> usersHaveSameQuestion;
  final String image;

  PostModel(
      this.isQuestion,
      this.usersHaveSameQuestion,
      UserModel userAsked,
      this.image,
      String tag,
      DateTime postedTime,
      String title,
      String subTitle,
      AddressModel address,
      List<LikeModel> likes,
      List<CommentModel> comments,
      isSaved,
      {hashTags})
      : super(PostInterface.postType, userAsked, tag, postedTime, title,
            subTitle, address, likes, comments, isSaved, hashTags);
}
