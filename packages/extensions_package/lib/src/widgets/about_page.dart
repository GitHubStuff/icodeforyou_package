import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    required this.title,
    required this.children,
    this.maxHeight = 200,
    super.key,
  });

  final Widget title;
  final List<Widget> children;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: maxHeight,
            child: Card(
              child: children[index],
            ),
          );
        },
      ),
    );
  }
}
