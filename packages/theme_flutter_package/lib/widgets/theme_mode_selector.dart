import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

/// A widget that displays a column of three radio buttons for theme mode selection:
/// 'Dark', 'Light', and 'System'. When a radio is selected, it calls the cubit's
/// setThemeMode() method. A double-tap anywhere in the widget dismisses it.
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the BrightnessCubit to get the current AppThemeMode.
    final brightnessCubit = context.watch<BrightnessCubit>();
    final selectedMode = brightnessCubit.appThemeMode; // using the getter

    return GestureDetector(
      onDoubleTap: () => Navigator.of(context).pop(),
      child: Container(
        //padding: const EdgeInsets.all(16),
        // Adjust constraints to suit modal, gear popover, or centered popover usage.
        constraints: const BoxConstraints(minWidth: 200, minHeight: 150),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // Optional shadow gives a popover/modal look.
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile<AppThemeMode>(
              title: const Text('Dark'),
              value: AppThemeMode.dark,
              groupValue: selectedMode,
              onChanged: (value) {
                if (value != null) {
                  context.read<BrightnessCubit>().setThemeMode(value);
                }
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Light'),
              value: AppThemeMode.light,
              groupValue: selectedMode,
              onChanged: (value) {
                if (value != null) {
                  context.read<BrightnessCubit>().setThemeMode(value);
                }
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('System'),
              value: AppThemeMode.system,
              groupValue: selectedMode,
              onChanged: (value) {
                if (value != null) {
                  context.read<BrightnessCubit>().setThemeMode(value);
                }
              },
            ),
          ],
        ),
      ).withPaddingAll(16),
    );
  }
}
