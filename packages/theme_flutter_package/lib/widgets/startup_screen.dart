import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart'
    show BrightnessCubit, NoSqlDB, SplashTransition;

/// Regular expression to validate directory names.
final RegExp _dirNameRegExp = RegExp(r'^[a-z][a-z0-9_]{1,}$');

const _fadeInDuration = Duration(milliseconds: 250);

class StartupScreen extends StatefulWidget {
  const StartupScreen({
    required this.homeScreen,
    required this.noSqlDB,
    this.noSqlDictoryName = 'nosqldb',
    this.splashScreen,
    this.splashDuration = const Duration(milliseconds: 550),
    this.fadeDuration = const Duration(milliseconds: 750),
    this.splashTransition = SplashTransition.fade,
    super.key,
  });

  final Widget homeScreen;
  final Widget? splashScreen;
  final NoSqlDB noSqlDB;
  final String noSqlDictoryName;
  final Duration splashDuration;
  final Duration fadeDuration;
  final SplashTransition splashTransition;

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  /// Flag to determine if the DB initialization has completed.
  bool _isDbInitialized = false;
  double _fadeInOpacity = 0;

  @override
  void initState() {
    super.initState();

    // Trigger the fade in animation on the next frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        setState(() => _fadeInOpacity = 1);
      });
    });

    _initAndStartUp();
  }

  /// Initialize the NoSqlDB, then start remaining async tasks and navigate.
  Future<void> _initAndStartUp() async {
    // Validate the directory name.
    if (!_dirNameRegExp.hasMatch(widget.noSqlDictoryName)) {
      throw Exception('Invalid directory name: ${widget.noSqlDictoryName}');
    }

    // Initialize the database.
    await widget.noSqlDB.init(dirName: widget.noSqlDictoryName);

    // Update state to indicate DB is ready.
    setState(() => _isDbInitialized = true);

    // Wait for both splash duration and additional async tasks.
    await _startUp();
  }

  /// Wait for minimum splash duration and async tasks, then navigate.
  Future<void> _startUp() async {
    final fadeInDuration = Future<void>.delayed(_fadeInDuration);
    final splashDelay = Future<void>.delayed(
      widget.splashDuration + _fadeInDuration,
    );
    final initTasks = _initializeAsyncTasks();
    await Future.wait([fadeInDuration, splashDelay, initTasks]);

    if (!mounted) return;

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: widget.fadeDuration,
        pageBuilder:
            (context, animation, secondaryAnimation) => widget.homeScreen,
        transitionsBuilder: widget.splashTransition.builder,
        /*
          final scaleAnimation = Tween<double>(begin: 0.2, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
          final rotateAnimation = Tween<double>(
            begin: 0.75, // 0.25 turns is 90 degrees
            end: 0,
          ).animate(animation);
          return RotationTransition(turns: rotateAnimation, child: child);

          return ScaleTransition(scale: scaleAnimation, child: child);
          return FadeTransition(opacity: animation, child: child);
        },
        */
      ),
    );
  }

  /// Simulate additional asynchronous initialization tasks.
  Future<void> _initializeAsyncTasks() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    // Until the database is initialized, show the splash UI.
    if (!_isDbInitialized) return _buildSplashUI();

    // After initialization, provide the BrightnessCubit and rebuild.
    return BlocProvider(
      create: (_) => BrightnessCubit(noSqlDb: widget.noSqlDB),
      child: BlocBuilder<BrightnessCubit, Brightness>(
        builder: (context, brightness) {
          final themeData = ThemeData(brightness: brightness);
          return Theme(data: themeData, child: _buildSplashUI());
        },
      ),
    );
  }

  /// Returns the splash UI (either the provided splashScreen or a spinner).
  Widget _buildSplashUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: _fadeInOpacity,
          duration: _fadeInDuration,
          child: widget.splashScreen ?? const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
