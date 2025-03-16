// Improves readability of examples
// ignore_for_file: avoid_redundant_argument_values

import 'package:extensions_package/extensions_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_package/theme_package.dart';

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
        },
        tooltip: null,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    final _ = context.read<ThemeCubit>();
    return const Center(child: CircularProgressIndicator());
  }
}
