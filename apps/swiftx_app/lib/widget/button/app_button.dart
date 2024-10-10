import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/icons/icon.dart';

enum ButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final AppIcons? icon;
  final String title;
  final GestureTapCallback? onTap;
  late ButtonType type;
  AppButton.primary({super.key, this.icon, required this.title, this.onTap}) {
    type = ButtonType.primary;
  }

  AppButton.secondary({super.key, this.icon, required this.title, this.onTap}) {
    type = ButtonType.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: type == ButtonType.primary
          ? Theme.of(context).primaryColor
          : Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            children: [
              if (icon != null) ...[
                AppIcon(
                  icon: icon!,
                  size: 30,
                  color: type == ButtonType.primary
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: type == ButtonType.primary
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
