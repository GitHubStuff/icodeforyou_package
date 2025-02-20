import 'package:about_package/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    required this.titleWidget,
    required this.demoWidgets,
    super.key,
  });

  final Widget titleWidget;
  final List<AboutContent> demoWidgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: titleWidget), body: _body(context));
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: demoWidgets.length,
        itemBuilder: (context, index) {
          final widget = demoWidgets[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute<Widget>(
                  builder: (_) => AboutDemo(aboutContent: widget),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: widget.title,
            ),
          ).withSymmetricPadding(vertical: 8);
        },
      ).withSymmetricPadding(horizontal: 20, vertical: 30),
    );
  }
}
