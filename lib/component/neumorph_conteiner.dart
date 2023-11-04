import 'package:flutter/material.dart';

import '../constant/colors.dart';

class NeumorphicContainer extends StatelessWidget {
  Widget? child;
  double? width;
  double? height;
  double? borderRadius;
  VoidCallback? onTap;

  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  NeumorphicContainer(
      {Key? key,
      this.child,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.borderRadius,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: DarkColors.background,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 24)),
          boxShadow: getShadows()),
      width: width,
      height: height,
      child: child,
    );

    return onTap != null
        ? GestureDetector(onTap: onTap, child: container)
        : container;
  }
}
