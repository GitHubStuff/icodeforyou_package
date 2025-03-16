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
        actions: const [ThemeSelectionAppBarButton()],
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
              builder: (context) => const Text('Zerk'),
            ),
          );
        },
        tooltip: 'Pushes a new screen',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    return const Center(child: Text('Hello World'));
  }
}
