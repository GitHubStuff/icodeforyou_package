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
        actions: const [ThemeSelectionAppBarButton()],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '?Press me?',
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
