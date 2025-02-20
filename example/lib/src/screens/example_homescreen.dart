// For readability in the demo
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icodeforyou_example/src/src.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

part 'about_analogclock.dart';
part 'about_aquabutton.dart';
part 'about_datetime.dart';
part 'about_extensions.dart';
part 'about_marquee.dart';
part 'about_theme.dart';

const AboutContent aboutContent = AboutContent(
  title: Text('About Content'),
  demo: Text('© 2021 ICodeForYou', style: TextStyle(fontSize: 24)),
  size: Size(300, 48),
);

class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({required this.title, super.key});

  final String title;

  @override
  State<ExampleHomeScreen> createState() => _MyHomeScreen();
}

class _MyHomeScreen extends ObservingStatefulWidget<ExampleHomeScreen> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeSelectionAppBarButton()],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: null,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _body(BuildContext context) {
    //return zerk(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _aboutAnalogClock(),
        const Gap(6),
        _aboutAquaButton(),
        const Gap(6),
        _aboutDateTime(),
        const Gap(6),
        _aboutExtensions(),
        const Gap(6),
        _aboutMarquee(context),
        const Gap(6),
        _aboutTheme(),
        // const AboutCard(
        //   title: Text('Giggerish Widget'),
        //   description: Text('© Nonsense'),
        //   demoWidgets: [
        //     aboutContent,
        //   ],
        // ),
      ],
    );
  }
}
