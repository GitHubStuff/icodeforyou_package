import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_package/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionButtons extends StatelessWidget {
  const OptionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final halfWidth = DateTimePicker.pickerSize.width / 2;
    const buttonHeight = DateTimePicker.buttonHeight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(context, 'Date', PickerType.date, halfWidth, buttonHeight),
        _buildButton(context, 'Time', PickerType.time, halfWidth, buttonHeight),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    PickerType type,
    double width,
    double height,
  ) {
    final themeExtension =
        Theme.of(context).extension<DateTimePickerThemeExtension>();

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final bgColor =
        type == PickerType.date
            ? themeExtension?.dateColor ??
                (isDarkMode ? Colors.grey[800] : Colors.blue[300])
            : themeExtension?.timeColor ??
                (isDarkMode ? Colors.purple[800] : Colors.purple[300]);

    final textColor = themeExtension?.textColor ?? theme.colorScheme.onSurface;
    final splashColor =
        themeExtension?.splashColor ??
        (isDarkMode ? Colors.green[900] : Colors.green[200]);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: bgColor,
        child: InkWell(
          onTap: () => context.read<DateTimeCubit>().changePickerType(type),
          splashColor: splashColor,
          child: Center(
            child: AutoSizeText(
              label,
              style: TextStyle(color: textColor, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
