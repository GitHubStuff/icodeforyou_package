import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';
import 'package:theme_package/src/src.dart';

class ThemeSettingWidget extends StatelessWidget {
  const ThemeSettingWidget({
    super.key,
    Widget? titleWidget,
    Widget? darkThemeWidget,
    Widget? systemThemeWidget,
    Widget? lightThemeWidget,
  }) : titleWidget =
           titleWidget ??
           const Text(
             'Theme',
             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
           ),
       darkThemeWidget = darkThemeWidget ?? const Text('Dark'),
       systemThemeWidget = systemThemeWidget ?? const Text('System'),
       lightThemeWidget = lightThemeWidget ?? const Text('Light');

  final Widget titleWidget;
  final Widget darkThemeWidget;
  final Widget lightThemeWidget;
  final Widget systemThemeWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final cubit = context.read<ThemeCubit>();
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleWidget,
              const Gap(4), // Small space below the title
              RadiobuttonAndLabel<ThemeState>(
                groupValue: state,
                value: ThemeState.dark,
                onChanged: (ThemeState? value) {
                  if (value != null) cubit.setTheme(ThemeMode.dark);
                },
                label: darkThemeWidget,
              ),
              RadiobuttonAndLabel<ThemeState>(
                groupValue: state,
                value: ThemeState.system,
                onChanged: (ThemeState? value) {
                  if (value != null) cubit.setTheme(ThemeMode.system);
                },
                label: systemThemeWidget,
              ),
              RadiobuttonAndLabel<ThemeState>(
                groupValue: state,
                value: ThemeState.light,
                onChanged: (ThemeState? value) {
                  if (value != null) cubit.setTheme(ThemeMode.light);
                },
                label: lightThemeWidget,
              ),
            ],
          ).withPaddingAll(10),
        );
      },
    );
  }
}
