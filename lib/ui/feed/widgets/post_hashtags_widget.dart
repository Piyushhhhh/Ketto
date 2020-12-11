import 'package:flutter/material.dart';
import 'package:kettotask/utils/text_style_type.dart';

class PostHashTagWidget extends StatelessWidget {
  final List<String> hashTags;

  PostHashTagWidget(this.hashTags);

  @override
  Widget build(BuildContext context) {
    if (hashTags == null || hashTags.length == 0) return SizedBox();
    return Wrap(
      runSpacing: 8,
      children: List<Widget>.generate(
          hashTags.length,
          (index) => Text(
                '#${hashTags[index]}',
                style: commonTextStyles.hashTagsText,
              )),
    );
  }
}
