import 'package:flutter/material.dart';
import 'package:kettotask/utils/text_style_type.dart';
import 'package:kettotask/model/bottom_nav_item.dart';

class BottomNavWidget extends StatefulWidget {
  final List<BottomNavItemModel> bottomNavItems;

  BottomNavWidget(this.bottomNavItems);

  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.3))),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: List<Widget>.generate(
          widget.bottomNavItems.length,
          (index) {
            GlobalKey key = GlobalKey();
            if (widget.bottomNavItems[index].valueNotifier != null &&
                widget.bottomNavItems[index].secondImage != null)
              return Expanded(
                child: ValueListenableBuilder(
                  valueListenable: widget.bottomNavItems[index].valueNotifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Material(
                        shape: StadiumBorder(),
                        color: Colors.transparent,
                        child: Stack(
                          key: key,
                          fit: StackFit.expand,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (widget.bottomNavItems[index].isCenter) {
                                  widget.bottomNavItems[index]
                                      .onTap(key, widget.bottomNavItems[index]);
                                } else
                                  widget.bottomNavItems[index].onTap();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    widget.bottomNavItems[index].text.isNotEmpty
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  AnimatedSwitcher(
                                    child: value
                                        ? SizedBox(
                                            height: widget.bottomNavItems[index]
                                                    .text.isNotEmpty
                                                ? 32
                                                : 42,
                                            width: widget.bottomNavItems[index]
                                                    .text.isNotEmpty
                                                ? 32
                                                : 42,
                                            key: UniqueKey(),
                                          )
                                        : Image.asset(
                                            widget.bottomNavItems[index].image,
                                            height: widget.bottomNavItems[index]
                                                    .text.isNotEmpty
                                                ? 32
                                                : 42,
                                            width: widget.bottomNavItems[index]
                                                    .text.isNotEmpty
                                                ? 32
                                                : 42,
                                            key: UniqueKey(),
                                          ),
                                    duration: Duration(milliseconds: 374),
                                  ),
                                  if (widget
                                      .bottomNavItems[index].text.isNotEmpty)
                                    Text(
                                      widget.bottomNavItems[index].text,
                                      style: commonTextStyles
                                          .bottomNavTextNotSelected,
                                      maxLines: 1,
                                    )
                                ],
                              ),
                            ),
                            if (widget.bottomNavItems[index].haveNotification ??
                                false)
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            else
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Material(
                    shape: StadiumBorder(),
                    color: Colors.transparent,
                    child: Stack(
                      key: key,
                      fit: StackFit.expand,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (widget.bottomNavItems[index].isCenter) {
                              widget.bottomNavItems[index]
                                  .onTap(key, widget.bottomNavItems[index]);
                            } else
                              widget.bottomNavItems[index].onTap();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                widget.bottomNavItems[index].text.isNotEmpty
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                widget.bottomNavItems[index].image,
                                height:
                                    widget.bottomNavItems[index].text.isNotEmpty
                                        ? 32
                                        : 42,
                                width:
                                    widget.bottomNavItems[index].text.isNotEmpty
                                        ? 32
                                        : 42,
                              ),
                              if (widget.bottomNavItems[index].text.isNotEmpty)
                                Text(
                                  widget.bottomNavItems[index].text,
                                  style:
                                      commonTextStyles.bottomNavTextNotSelected,
                                  maxLines: 1,
                                )
                            ],
                          ),
                        ),
                        if (widget.bottomNavItems[index].haveNotification ??
                            false)
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
