import 'package:kettotask/model/user.dart';

class CommentModel {
  final UserModel user;
  final String comment;
  final DateTime commentedAt;
  final List<String> images;
  final List<CommentModel> replies;

  CommentModel(this.user, this.comment, this.images, this.commentedAt,
      {this.replies});
}
