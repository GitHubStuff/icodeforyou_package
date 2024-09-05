import 'package:extensions_package/src/widgets/widget_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
    required this.title,
    required this.content,
    required this.aboutPage,
    super.key,
  });

  final Widget content;
  final Widget title;
  final Widget aboutPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute<Widget>(
            builder: (context) => aboutPage,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top line with centered text and disclose button on the right
            Row(
              children: [
                Expanded(child: Center(child: title)),
                const IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: null,
                ),
              ],
            ),
            // Body part with left-justified widget
            Align(
              alignment: Alignment.centerLeft,
              child: content,
            ).withPaddingAll(8),
          ],
        ),
      ),
    );
  }
}
