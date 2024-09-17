import 'package:flutter/material.dart';

class RadiobuttonAndLabel<S> extends StatelessWidget {
  const RadiobuttonAndLabel({
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
  });

  final S groupValue;
  final S value;
  final ValueChanged<S?> onChanged;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: label,
      leading: Radio<S>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(value),
      visualDensity: VisualDensity.compact,
      dense: true,
    );
  }
}
