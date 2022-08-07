import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double elevation;
  final bool automaticallyImplyLeading;
  final double titleSpacing;
  final bool centerTitle;
  final bool isCustomLeading;
  final IconData? customIcon;
  final Widget? customTitle;
  final List<Widget>? customAction;

  KAppBar({
    Key? key,
    this.title,
    this.elevation = 0,
    this.centerTitle = false,
    this.titleSpacing = 0,
    this.automaticallyImplyLeading = true,
    this.isCustomLeading = false,
    this.customIcon,
    this.customTitle,
    this.customAction,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KColor.primary,
      elevation: elevation,
      titleSpacing: !automaticallyImplyLeading
          ? NavigationToolbar.kMiddleSpacing
          : titleSpacing,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(color: KColor.black),
      leading: isCustomLeading
          ? IconButton(
              icon: Icon(
                customIcon,
                color: KColor.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      centerTitle: centerTitle,
      title: customTitle != null
          ? Transform.translate(offset: Offset(-15, 0), child: customTitle)
          : title != null
              ? Text(title!,
                  style: KTextStyle.headline6.copyWith(color: KColor.gray))
              : null,
      actions: customAction,
    );
  }
}
