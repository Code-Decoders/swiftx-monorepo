import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'icons.dart';

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double? size;
  final Color? color;
  const AppIcon({super.key, required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/${icon.name}.svg",
      width: size,
      height: size,
      color: color,
    );
  }
}