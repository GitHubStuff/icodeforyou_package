import 'package:datetime_package/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class DateTimePicker extends StatelessWidget {
  DateTimePicker({
    required this.onSelectedDateTime,
    DateTime? dateTime,
    this.hapticFeedback = false,
    this.dateFormat = 'EEE d-MMM-yyyy',
    this.timeFormat = 'h:mm:ss a',
    super.key,
  }) : initialDateTime = dateTime ?? DateTime.now();

  static const size = Size(240, 270);

  static const buttonHeight = 56.0;
  static const itemExtent = 35.0;
  static const itemWidth = 80.0;
  static const pickerSize = Size(itemWidth * 3, 140);
  static const style = TextStyle(fontSize: 24);

  final bool hapticFeedback;
  final DateTime initialDateTime;
  final String dateFormat;
  final String timeFormat;
  final void Function(DateTime) onSelectedDateTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DateTimeCubit>(
      create: (context) => DateTimeCubit(starting: initialDateTime),
      child: _body().withPaddingAll(25),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DateTimeHeader(
          onDateTimeSelected: onSelectedDateTime,
          hapticFeedback: hapticFeedback,
        ),
        const OptionButtons(),
        BlocBuilder<DateTimeCubit, DateTimeState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child:
                  state.pickerType == PickerType.date
                      ? DatePickerWidget(state.dateTime, key: const ValueKey(1))
                      : TimePickerWidget(
                        state.dateTime,
                        key: const ValueKey(2),
                      ),
            );
          },
        ),
      ],
    ).withBorder(Colors.black, width: 1.6);
  }
}
