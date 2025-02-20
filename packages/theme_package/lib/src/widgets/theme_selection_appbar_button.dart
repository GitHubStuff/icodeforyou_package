import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class ThemeSelectionAppBarButton extends StatelessWidget {
  const ThemeSelectionAppBarButton({this.iconData, super.key});

  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData ?? Icons.settings), // Gear icon
      onPressed: () => _showThemeSelection(context),
    );
  }

  void _showThemeSelection(BuildContext context) {
    if (kIsWeb || context.isTablet) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return Stack(
            // Ensure it doesn't cover the whole screen
            children: [
              Positioned(
                top: AppBar().preferredSize.height,
                right: 5,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                  ), // Control the width of the modal
                  child: const ThemeSettingWidget(),
                ),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute<Widget>(builder: (context) => const SettingsPage()),
      );
    }
  }
}
