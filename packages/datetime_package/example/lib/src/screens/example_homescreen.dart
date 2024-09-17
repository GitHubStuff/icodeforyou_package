// ignore_for_file: avoid_redundant_argument_values

import 'package:datetime_package_example/src/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

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
        onPressed: () {},
        tooltip: null,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            DateTimeDifferenceOriginal(
              startEvent: DateTime(1960, 12, 1, 15, 56),
              endEvent: DateTime.now(),
            ).toString(),
          ).fontSize(26),
          Text(
            DateTimeDifference(
              startEvent: DateTime(1960, 12, 1, 15, 56),
              endEvent: DateTime.now(),
            ).toString(),
          ).fontSize(26),
        ],
      ),
    );
  }
}
