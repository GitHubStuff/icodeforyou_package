// ignore_for_file: avoid_redundant_argument_values

import 'package:_template_app_flutter/src/src.dart';
import 'package:extensions_package/extensions_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({required this.title, super.key});

  final String title;

  @override
  State<ExampleHomeScreen> createState() => _MyHomeScreen();
}

class _MyHomeScreen extends ObservingStatefulWidget<ExampleHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // Gear icon
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute<Widget>(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //context.read<ThemeModeCubit>().toggleBrightness();
          Navigator.push(
            context,
            CupertinoPageRoute<Widget>(
              builder: (context) => const AboutPage(
                title: Text('About HERE'),
                children: [Text('Boo!'), Text('Boo!'), Text('Boo!')],
              ),
            ),
          );
        },
        tooltip: null,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: AboutCard(
        aboutPage: const AboutPage(
          title: Text('About HERE'),
          children: [Text('Boo!'), Text('Boo!'), Text('Boo!')],
        ),
        title: Text(
          'About',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This is an example app.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
