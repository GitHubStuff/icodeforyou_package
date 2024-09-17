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

  Future<void> _showModal(BuildContext context) async {
    final result = await showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
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
        splashColor: theme.colorScheme.primary.withOpacity(0.3),
        onTap: () => _showModal(context),
        child: triggerWidget,
      ),
    );
  }
}
