class UserModel {
  final String name;
  final String userProfileURL;
  final String userId;
  final int id;
  final DateTime diagnosedDate;
  final String tag;
  final String title;

  UserModel(
      this.name, this.userProfileURL, this.userId, this.id, this.diagnosedDate,
      {this.tag, this.title});
}
