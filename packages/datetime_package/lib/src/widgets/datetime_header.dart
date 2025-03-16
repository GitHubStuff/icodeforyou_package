// Improve readability
// ignore_for_file: avoid_redundant_argument_values

import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_package/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';
import 'package:intl/intl.dart';

final _group = AutoSizeGroup();

class DateTimeHeader extends StatelessWidget {
  const DateTimeHeader({
    required this.onDateTimeSelected,
    required this.hapticFeedback,
    this.dateFormat = 'EEE d-MMM-yyyy',
    this.timeFormat = 'h:mm:ss a',
    super.key,
  });

  final void Function(DateTime) onDateTimeSelected;
  final bool hapticFeedback;
  final String dateFormat;
  final String timeFormat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        final (backgroundColor, textColor) = _color(context);
        final formattedDate = DateFormat(
          dateFormat,
        ).format(state.dateTime.toLocal());
        final formattedTime = DateFormat(
          timeFormat,
        ).format(state.dateTime.toLocal());
        return SizedBox(
          width: DateTimePicker.pickerSize.width, // Set fixed width
          height: 70, // Set fixed height
          child: ColoredBox(
            color: backgroundColor, // Set background color
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center icon vertically
                children: [
                  // Left side: Two Text widgets in a Column
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          formattedDate,
                          group: _group,
                          style: TextStyle(color: textColor, fontSize: 20),
                          maxLines: 1,
                          minFontSize: 8,
                        ),
                        AutoSizeText(
                          formattedTime,
                          group: _group,
                          style: TextStyle(color: textColor, fontSize: 20),
                          maxLines: 1,
                          minFontSize: 8,
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      onDateTimeSelected(state.dateTime.toUtc());
                      if (hapticFeedback) Haptic.heavyImpact.haptic;
                    },
                    child: SizedBox(
                      width: 40, // Icon gets fixed width
                      child: AquaButton(
                        materialColor: createMaterialColor(Colors.green),
                        radius: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  (Color bg, Color txt) _color(BuildContext context) {
    final themeExtension =
        Theme.of(context).extension<DateTimePickerThemeExtension>();
    final pickerType = context.read<DateTimeCubit>().state.pickerType;
    switch (pickerType) {
      case PickerType.date:
        final backgroundColor =
            themeExtension?.dateColor ??
            Theme.of(context).colorScheme.primaryContainer;
        final textColor =
            themeExtension?.textColor ??
            Theme.of(context).colorScheme.onPrimary;
        return (backgroundColor, textColor);

      case PickerType.time:
        final backgroundColor =
            themeExtension?.timeColor ??
            Theme.of(context).colorScheme.secondaryContainer;
        final textColor =
            themeExtension?.textColor ??
            Theme.of(context).colorScheme.onSecondary;
        return (backgroundColor, textColor);
    }
  }
}
