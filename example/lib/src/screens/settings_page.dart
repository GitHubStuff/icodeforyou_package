import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    this.leadingWidget,
    this.titleWidget,
  });

  final Widget? leadingWidget;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final title = titleWidget ?? const Text('My Settings');
    return Scaffold(
      appBar: AppBar(
        title: title,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: leadingWidget ?? const Icon(Icons.arrow_back),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          // ThemeButtons(),
          // ThemeWidget(),
          ThemeSettingWidget(),
        ],
      ),
    );
  }
}
