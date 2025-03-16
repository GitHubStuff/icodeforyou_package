import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class ThemeApp extends StatefulWidget {
  const ThemeApp({
    required this.splashScreen,
    required this.parentScreen,
    this.darkTheme,
    this.debugShowCheckedModeBanner = true,
    this.blocProviders = const <BlocProvider>[],
    this.darkThemeExtensions = const <ThemeExtension>[],
    this.lightThemeExtensions = const <ThemeExtension>[],
    this.fadeDuration = Duration.zero,
    this.lightTheme,
    this.splashDuration = Duration.zero,
    super.key,
  });

  final List<BlocProvider> blocProviders;
  final ThemeData? darkTheme;
  final List<ThemeExtension> darkThemeExtensions;
  final bool debugShowCheckedModeBanner;
  final Duration fadeDuration;
  final ThemeData? lightTheme;
  final List<ThemeExtension> lightThemeExtensions;
  final Widget parentScreen;
  final Duration splashDuration;
  final Widget splashScreen;

  @override
  ObservingStatefulWidget<ThemeApp> createState() => _ThemeApp();
}

class _ThemeApp extends ObservingStatefulWidget<ThemeApp> {
  AppLifecycleState? appLifecycleState;
  final splashCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Future.delayed(widget.splashDuration, splashCompleter.complete);
  }

  Widget _material(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        return MaterialApp(
          builder: (_, child) {
            return ColoredBox(color: Colors.black, child: child);
          },
          darkTheme: (widget.darkTheme ?? ThemeData.dark()).copyWith(
            extensions: [...widget.darkThemeExtensions],
          ),
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          home: _showSplashThenParent(),
          theme: (widget.lightTheme ?? ThemeData.light()).copyWith(
            extensions: [...widget.lightThemeExtensions],
          ),
          themeMode: state.mode,
        );
      },
    );
  }

  Widget _showSplashThenParent() {
    return FutureBuilder<void>(
      future: splashCompleter.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _fadeFromSplashToParent(
                context,
                page: widget.parentScreen,
                duration: widget.fadeDuration,
              );
            }
          });
        }
        return ColoredBox(color: Colors.black, child: widget.splashScreen);
      },
    );
  }

  void _fadeFromSplashToParent(
    BuildContext context, {
    required Widget page,
    required Duration duration,
  }) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<Object>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: duration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...widget.blocProviders],
      child: _material(context),
    );
  }
}
