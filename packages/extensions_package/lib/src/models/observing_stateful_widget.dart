import 'package:flutter/material.dart';

/// Adds helpers:
///  afterFirstLayout
///  didChangeAppLifecycleState
///  didChangeMetrics
///  didChangePlatformBrightness
///  didChangeTextScaleFactor

abstract class ObservingStatefulWidget<T extends StatefulWidget>
    extends State<T>
    with WidgetsBindingObserver {
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    final instance = WidgetsBinding.instance;
    reportTextScaleFactor(instance.platformDispatcher.textScaleFactor);
    instance
      ..addPostFrameCallback((_) => afterFirstLayout(context))
      ..addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  /*
Ensures Updated Data: This method guarantees that the MediaQuery.of(context)
reflects the latest device metrics before calling the refresh method on your
MediaQueryCubit.

Avoids Overlap: Even though addPostFrameCallback is called each time 
didChangeMetrics is invoked, the callback itself is only run once per frame. 
This approach doesn't lead to callbacks stacking up because each is only executed
after the metrics have changed and the frame has been processed.

Performance: This method is efficient and commonly used in Flutter applications
for handling updates based on screen metrics or orientation changes. It does not
significantly affect performance as it only schedules a single callback to run
after the current frame.
*/
  @mustCallSuper
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Add a post-frame callback to ensure MediaQuery has updated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Now it's safe to read the updated MediaQuery
      //eg: context.read<MediaQueryCubit>().refresh(context);
    });
  }

  @override
  void didChangePlatformBrightness() {}

  @mustCallSuper
  @override
  void didChangeTextScaleFactor() {
    final textScalceFactor =
        WidgetsBinding.instance.platformDispatcher.textScaleFactor;
    reportTextScaleFactor(textScalceFactor);
  }

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void afterFirstLayout(BuildContext context) {}

  /// Called when the text scale factor changes.
  void reportTextScaleFactor(double? textScaleFactor) {}
}
