import 'package:flutter/material.dart';

import '../component/neumorph_conteiner.dart';

class NeumorphicIcon extends StatelessWidget {
  Icon icon;
  Color iconColor;
  VoidCallback? onPressed;

  NeumorphicIcon(
      {Key? key, required this.icon, required this.iconColor, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: 64,
      width: 64,
      borderRadius: 12,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: iconColor,
      ),
    );
  }
}
