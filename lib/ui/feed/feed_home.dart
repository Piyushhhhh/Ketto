import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kettotask/bloc/overlays/bloc.dart';
import 'package:kettotask/bloc/overlays/event.dart';
import 'package:kettotask/utils/theme.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/utils/menu.dart' as menu;
import 'package:kettotask/interfaces/post_interface.dart';
import 'package:kettotask/model/address.dart';
import 'package:kettotask/model/article.dart';
import 'package:kettotask/model/bottom_nav_item.dart';
import 'package:kettotask/model/bottom_nav_menu_item.dart';
import 'package:kettotask/model/comment.dart';
import 'package:kettotask/model/event.dart';
import 'package:kettotask/model/like.dart';
import 'package:kettotask/model/post.dart';
import 'package:kettotask/model/user.dart';
import 'package:kettotask/ui/feed/widgets/article_item_widget.dart';
import 'package:kettotask/ui/feed/widgets/bottom_nav_menu_item_widget.dart';
import 'package:kettotask/ui/feed/widgets/bottom_nav_widget.dart';
import 'package:kettotask/ui/feed/widgets/event_item.dart';
import 'package:kettotask/ui/feed/widgets/post_item.dart';
import 'package:kettotask/ui/question/details.dart';

class FeedHome extends StatefulWidget {
  @override
  _FeedHomeState createState() => _FeedHomeState();
}

class _FeedHomeState extends State<FeedHome> {
  List<String> dropDown;
  String selectedFeedTitle;
  List<String> tags;
  String selectedTag;
  List<PostInterface> posts;
  List<ArticleModel> articles;
  bool articleDisplayed;
  List<BottomNavItemModel> bottomNavItems;
  List<BottomNavMenuItemModel> bottomNavMenuItems;
  ScrollController postsScrollController;
  ValueNotifier<bool> isMenuShowing;

  RelativeRect positionByKey(BuildContext c) {
    final RenderBox bar = c.findRenderObject();
    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(
            bar.size.topCenter(
                Offset(0, -MediaQuery.of(context).size.height * 0.4)),
            ancestor: overlay),
        bar.localToGlobal(bar.size.topCenter(Offset(0, -100)),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  showCenterMenu(GlobalKey key, BottomNavItemModel item) async {
    item.valueNotifier?.value = true;

    await showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 0),
      context: context,
      pageBuilder: (_, __, ___) {
        Widget widget = Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: ListView.separated(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              shrinkWrap: true,
              itemBuilder: (context, index) => menu.PopupMenuItem<String>(
                    child: BottomNavMenuItemWidget(bottomNavMenuItems[index]),
                    value: bottomNavMenuItems[index].title,
                  ),
              separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
              itemCount: bottomNavMenuItems.length),
        );

        return GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
              ),
              alignment: Alignment.bottomCenter,
              child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      widget,
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 72,
                        child: Center(
                          child: Image.asset(
                            "assets/images/Expanded.png",
                            height: 42,
                            width: 42,
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                    ],
                  ))),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
    item.valueNotifier?.value = false;
  }

  clearOverlay() {
    BlocProvider.of<OverLayBloc>(context)
      ..add(RemoveOverLays(PostInterface.eventType, context));
    BlocProvider.of<OverLayBloc>(context)
      ..add(RemoveOverLays(PostInterface.postType, context));
  }

  openDetailsPage(PostInterface post) {
    Get.to(DetailsPage(post));
  }

  scrollListener() {
    print(1);
    clearOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        clearOverlay();
      },
      onVerticalDragStart: (a) {
        clearOverlay();
      },
      child: Scaffold(
        backgroundColor: Color(0xffE8EBEF),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'COMMUNITY',
                        style: commonTextStyles.homeFeedSubTitleText,
                      ),
                      subtitle: DropdownButton<String>(
                        underline: SizedBox(),
                        onChanged: (a) {},
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: themes.primaryColor,
                        ),
                        style: commonTextStyles.homeFeedTitleText,
                        value: selectedFeedTitle,
                        items: dropDown
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                  onTap: () {
                                    setState(() {
                                      selectedFeedTitle = e;
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      trailing: CircleAvatar(
                        maxRadius: 20,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://i2.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: themes.secondaryPrimaryColor)),
                                  focusColor: themes.secondaryPrimaryColor,
                                  hintText: 'Search posts and members',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: themes.secondaryPrimaryColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: themes.primaryColor)),
                                  hintStyle:
                                      commonTextStyles.homePostFieldHintText,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.search,
                                    size: 18,
                                    color: themes.secondaryGrey,
                                  )),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/images/homeNotificationIcon.png",
                              height: 24,
                              width: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      padding: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 0.3))),
                      child: ListView.separated(
                          controller: postsScrollController,
                          separatorBuilder: (context, index) => SizedBox(
                                width: 12,
                              ),
                          itemCount: tags.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTag = tags[index];
                                  });
                                },
                                child: Chip(
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: themes.secondaryPrimaryColor)),
                                  backgroundColor:
                                      tags[index].compareTo(selectedTag) == 0
                                          ? themes.secondaryPrimaryColor
                                          : Colors.white,
                                  label: Text(
                                    tags[index],
                                    style:
                                        TextStyle(color: themes.primaryColor),
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 12),
                    itemBuilder: (context, index) {
                      Widget article;
                      if (!articleDisplayed &&
                          articles != null &&
                          articles.length > 0 &&
                          (index > 3 || index == (posts.length - 1))) {
                        article = article = SizedBox(
                          height: 165,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  'LATEST ARTICLES',
                                  style: commonTextStyles.articleListTitle,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                child: ListView.separated(
                                    padding: EdgeInsets.only(left: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) =>
                                        ArticleItemWidget(articles[i]),
                                    separatorBuilder: (context, i) => SizedBox(
                                          width: 16,
                                        ),
                                    itemCount: articles.length),
                              ),
                              SizedBox(
                                height: 14,
                              )
                            ],
                          ),
                        );
                        articleDisplayed = true;
                      }
                      var model;
                      Widget postWidget;
                      if (posts[index] is PostModel) {
                        model = posts[index];
                        postWidget = PostItemWidget(
                          model,
                          onItemTap: openDetailsPage,
                        );
                      } else if (posts[index] is EventModel) {
                        model = posts[index];
                        postWidget = EventWidgetItem(
                          model,
                        );
                      } else
                        return SizedBox();

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          postWidget,
                          if (article != null)
                            SizedBox(
                              height: 10,
                            ),
                          if (article != null) article
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: posts.length),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavWidget(bottomNavItems),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    postsScrollController = ScrollController();
    postsScrollController.addListener(scrollListener);

    isMenuShowing = ValueNotifier(false);

    dropDown = ['All Communities', 'Bengaluru', 'Mumbai'];
    tags = ['All Posts', 'News', 'Diet', 'LifeStyle', 'Symptom', 'Health'];
    selectedTag = tags[0];
    selectedFeedTitle = dropDown[0];
    articleDisplayed = false;
    bottomNavItems = [
      BottomNavItemModel("assets/images/Feedfeed.png", "Feed", () {},
          haveNotification: true),
      BottomNavItemModel(
        "assets/images/Librarylibrary.png",
        "Library",
        () {},
      ),
      BottomNavItemModel("assets/images/cente_nav.png", "", showCenterMenu,
          isCenter: true,
          valueNotifier: isMenuShowing,
          secondImage: "assets/images/Expanded.png"),
      BottomNavItemModel(
        "assets/images/Messages.png",
        "Messages",
        () {},
      ),
      BottomNavItemModel(
        "assets/images/Services.png",
        "Services",
        () {},
      )
    ];
    bottomNavMenuItems = [
      BottomNavMenuItemModel(Icons.edit, "Create a post",
          "Share your thoughts with community", () {}),
      BottomNavMenuItemModel(FontAwesomeIcons.questionCircle, "Ask a question",
          "Any doubts? Ask the communtiy", () {}),
      BottomNavMenuItemModel(
          Icons.poll, "Start a poll", "Need the opinion of the many?", () {}),
      BottomNavMenuItemModel(Icons.date_range, "Organise an Event",
          "Start a meet with people to share your joys", () {})
    ];
    posts = [
      PostModel(
          true,
          [
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
          ],
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'https://img.etimg.com/thumb/width-640,height-480,imgsize-144736,resizemode-1,msid-69037337/fraud-is-only-possible-if-user-grants-access-oldrich-mller-coo-anydesk.jpg',
          'Diet',
          DateTime.now(),
          'What are signs and symptoms of skin cancer?',
          'I\'ve been facing a few possible symptoms of skin cancer. I\'ve googled the possiblities b u I thought I\'d ask the community insted. What you guys think of it',
          AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
          [],
          [
            CommentModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    2,
                    DateTime.now(),
                    tag: "INFLUENCER",
                    title: "5+ YRS CHAMPION"),
                "Not sure about rights. Looks like its a matter of concern that our schools don't take it seriously such matters and treat it. So lightly like its a fault of a student",
                [],
                DateTime.now()),
            CommentModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    3,
                    DateTime.now()),
                "Not sure about rights. Looks like its a matter of concern that our schools don't take it seriously such matters and treat it. So lightly like its a fault of a student",
                [],
                DateTime.now()),
            CommentModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    4,
                    DateTime.now()),
                "Not sure about rights. Looks like its a matter of concern that our schools don't take it seriously such matters and treat it. So lightly like its a fault of a student",
                [],
                DateTime.now()),
            CommentModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    5,
                    DateTime.now()),
                "Not sure about rights. Looks like its a matter of concern that our schools don't take it seriously such matters and treat it. So lightly like its a fault of a student",
                [],
                DateTime.now()),
            CommentModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                "Not sure about rights. Looks like its a matter of concern that our schools don't take it seriously such matters and treat it. So lightly like its a fault of a student",
                [],
                DateTime.now()),
          ],
          false),
      EventModel(
          [],
          'CANCER MEET AT RAJEEV GANDHI NATIONAL PARK',
          DateTime.now(),
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'Diet',
          DateTime.now(),
          'What are signs and symptoms of skin cancer?',
          'I\'ve been facing a few possible symptoms of skin cancer. I\'ve googled the possiblities b u I thought I\'d ask the community insted. What you guys think of it',
          AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
          [
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
          ],
          [],
          false),
      PostModel(
          false,
          [
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
          ],
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          '',
          'Diet',
          DateTime.now(),
          'What are signs and symptoms of skin cancer?',
          'I\'ve been facing a few possible symptoms of skin cancer. I\'ve googled the possiblities b u I thought I\'d ask the community insted. What you guys think of it',
          AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
          [],
          [],
          false),
      PostModel(
        false,
        [],
        UserModel('Some User', '', 'user987', 1, DateTime.now(), tag: "EXPERT"),
        'assets/images/imagejeetega_india.png',
        'LifeStyle',
        DateTime.now(),
        '',
        'Somthing to motivate you',
        AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
        [
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
        ],
        [],
        false,
        hashTags: ['itsokayto', 'cancersurvivor'],
      ),
      PostModel(
          true,
          [
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
          ],
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'https://img.etimg.com/thumb/width-640,height-480,imgsize-144736,resizemode-1,msid-69037337/fraud-is-only-possible-if-user-grants-access-oldrich-mller-coo-anydesk.jpg',
          'Diet',
          DateTime.now(),
          'What are signs and symptoms of skin cancer?',
          'I\'ve been facing a few possible symptoms of skin cancer. I\'ve googled the possiblities b u I thought I\'d ask the community insted. What you guys think of it',
          AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
          [],
          [],
          false),
      EventModel(
          [],
          'CANCER MEET AT RAJEEV GANDHI NATIONAL PARK',
          DateTime.now(),
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'Diet',
          DateTime.now(),
          'What are signs and symptoms of skin cancer?',
          'I\'ve been facing a few possible symptoms of skin cancer. I\'ve googled the possiblities b u I thought I\'d ask the community insted. What you guys think of it',
          AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
          [
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
            LikeModel(
                UserModel(
                    'Rohit Shetty',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                    'rohit.shetty12',
                    1,
                    DateTime.now()),
                DateTime.now()),
          ],
          [],
          false),
      PostModel(
          false,
          [
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
            UserModel(
                'Rohit Shetty',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                'rohit.shetty12',
                1,
                DateTime.now()),
          ],
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          '',
          'Diet',
          DateTime.now(),
          'What are signs and symptoms of skin cancer?',
          'I\'ve been facing a few possible symptoms of skin cancer. I\'ve googled the possiblities b u I thought I\'d ask the community insted. What you guys think of it',
          AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
          [],
          [],
          false),
      PostModel(
        false,
        [],
        UserModel('Some User', '', 'user987', 1, DateTime.now(), tag: "EXPERT"),
        'assets/images/imagejeetega_india.png',
        'LifeStyle',
        DateTime.now(),
        '',
        'Somthing to motivate you',
        AddressModel('Ideal tower', 'Shankheshwar nagar', 'Nalasopara'),
        [
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
          LikeModel(
              UserModel(
                  'Rohit Shetty',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
                  'rohit.shetty12',
                  1,
                  DateTime.now()),
              DateTime.now()),
        ],
        [],
        false,
        hashTags: ['itsokayto', 'cancersurvivor'],
      ),
    ];
    articles = [
      ArticleModel(
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'Genetic testing plays an important role in pervention of cancer Lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
          ''),
      ArticleModel(
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'Genetic testing plays an important role in pervention of cancer Lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
          ''),
      ArticleModel(
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'Genetic testing plays an important role in pervention of cancer Lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
          ''),
      ArticleModel(
          UserModel(
              'Rohit Shetty',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7FFrxhGko3hUyRhuXBo8cpFfx_cdN5z6syFiBHJBJNUyl2SFf&usqp=CAU',
              'rohit.shetty12',
              1,
              DateTime.now()),
          'Genetic testing plays an important role in pervention of cancer Lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
          '')
    ];
  }
}
