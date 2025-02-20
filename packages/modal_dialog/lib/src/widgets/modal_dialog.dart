import 'package:flutter/material.dart';

class ModalDialog<T> extends StatelessWidget {
  const ModalDialog({
    required this.triggerWidget,
    required this.child,
    required this.onReturnValue,
    super.key,
  });

  final Widget triggerWidget;
  final Widget Function(void Function(T) returnValue) child;
  final void Function(T?) onReturnValue;

  Color _setOpacity({required Color onColor, required double toOpacity}) {
    assert(toOpacity >= 0 && toOpacity <= 1, 'Opacity must be between 0 and 1');
    int inline(double value) => (value * 255).toInt();
    final red = inline(onColor.r);
    final green = inline(onColor.g);
    final blue = inline(onColor.b);
    return Color.fromRGBO(red, green, blue, toOpacity.clamp(0.0, 1.0));
  }

  Future<void> _showModal(BuildContext context) async {
    final result = await showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: _setOpacity(
            onColor: Theme.of(context).colorScheme.onSurface,
            toOpacity: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Custom rounded corners
          ),
          child: Padding(
            padding: EdgeInsets
                .zero, // THIS controls the space between the border and the child
            child: child((T value) {
              Navigator.of(context).pop(value);
            }),
          ),
        );
      },
    );
    onReturnValue(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      child: InkWell(
        splashColor: _setOpacity(
          onColor: theme.colorScheme.primary,
          toOpacity: 0.3,
        ),
        onTap: () => _showModal(context),
        child: triggerWidget,
      ),
    );
  }
}
