import 'package:about_package/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
    required this.title,
    required this.description,
    required this.demoWidgets,
    super.key,
  });

  final Widget description;
  final Widget title;
  final List<AboutContent> demoWidgets;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute<Widget>(
            builder:
                (context) =>
                    AboutPage(titleWidget: title, demoWidgets: demoWidgets),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: ListTile(
          title: Center(child: title),
          subtitle: description,
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
