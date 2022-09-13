import 'package:flutter/material.dart';

import '../../app_config/app_image.dart';
import '../../model/horizontal_profile.dart';
import 'text_widget.dart';

class ListProfileHorizontalWidget extends StatefulWidget {
  ListProfileHorizontalWidget({
    Key? key,
    this.isPayScreen = false,
    required this.size,
    required this.colorScheme,
    required this.listHorizontalProfile,
    required this.expandedIndex,
    required this.onTap,
  }) : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final int expandedIndex;
  bool isPayScreen;
  final List<ListHorizontalProfile> listHorizontalProfile;
  final Function(int index) onTap;

  @override
  State<ListProfileHorizontalWidget> createState() =>
      _ListProfileHorizontalWidgetState();
}

class _ListProfileHorizontalWidgetState
    extends State<ListProfileHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * .1,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 27),
          scrollDirection: Axis.horizontal,
          itemCount: widget.listHorizontalProfile.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  widget.onTap(index);
                });
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.isPayScreen
                          ? Image.asset(
                              widget.listHorizontalProfile[index].image,
                              width: 25,
                              height: 25,
                            )
                          : Icon(
                              widget.listHorizontalProfile[index].icon,
                              size: 22,
                              color: widget.colorScheme.onSurface,
                            ),
                      const SizedBox(
                        width: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: TextWidget(
                          title: widget.listHorizontalProfile[index].title,
                          fontSize: 17,
                          color: widget.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  widget.expandedIndex == index
                      ? Image.asset(AppImage.divider)
                      : const SizedBox(),
                  Divider(
                    color: widget.colorScheme.onSurface,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
