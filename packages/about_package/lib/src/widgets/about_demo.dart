import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class AboutDemo extends StatefulWidget {
  const AboutDemo({required this.aboutContent, super.key});

  final AboutContent aboutContent;

  @override
  ObservingStatefulWidget<AboutDemo> createState() => _AboutDemo();
}

class _AboutDemo extends ObservingStatefulWidget<AboutDemo> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_displayAboutSnackbar(context)],
        title: widget.aboutContent.title,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return PositionAndSizeWidget(
      onLayout: (size, position) {
        setState(() {
          height = size.height;
          width = size.width;
        }); // This is the line that causes the error
      },
      child: widget.aboutContent.demo,
    );
  }

  IconButton _displayAboutSnackbar(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Size: $width x $height'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
