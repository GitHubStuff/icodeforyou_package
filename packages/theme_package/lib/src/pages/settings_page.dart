import 'package:flutter/material.dart';
import 'package:theme_package/src/src.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, this.dismissWidget, this.titleWidget});

  final Widget? dismissWidget;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final title = titleWidget ?? const Text('Theme Settings');
    return Scaffold(
      appBar: AppBar(
        title: title,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: dismissWidget ?? const Icon(Icons.arrow_back),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return const Center(child: Column(children: [ThemeSettingWidget()]));
  }
}
