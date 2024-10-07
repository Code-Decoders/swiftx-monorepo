import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/icons/icon.dart';

class OperationalButton extends StatelessWidget {
  final AppIcons icon;
  final String title;
  final GestureTapCallback? onTap;
  final Color? color;
  const OperationalButton(
      {super.key,
      required this.icon,
      required this.title,
      this.onTap,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                AppIcon(
                  icon: icon,
                  size: 30,
                  color: color ?? Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 5),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
