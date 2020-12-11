import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/article.dart';
import 'package:kettotask/utils/theme.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleModel articleModel;

  ArticleItemWidget(this.articleModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: (articleModel.userModel.userProfileURL != null &&
                            articleModel.userModel.userProfileURL.isNotEmpty)
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                articleModel.userModel.userProfileURL))
                        : AssetImage(
                            "assets/images/Vectorexpert.png",
                          )),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                articleModel.userModel.name,
                style: commonTextStyles.articleItemUserNameText,
              )
            ],
          ),
          Text(
            articleModel.articleText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'READ ARTICLE',
                style: commonTextStyles.readArticleItemText,
              ),
              Icon(
                Icons.chevron_right,
                color: themes.primaryColor,
                size: 16,
              )
            ],
          )
        ],
      ),
    );
  }
}
