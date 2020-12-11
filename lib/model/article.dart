import 'package:kettotask/model/user.dart';

class ArticleModel {
  final UserModel userModel;
  final String articleText;
  final String articleUrl;

  ArticleModel(this.userModel, this.articleText, this.articleUrl);
}
