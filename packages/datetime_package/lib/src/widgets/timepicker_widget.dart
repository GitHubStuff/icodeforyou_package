import 'package:datetime_package/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

const double _compression = 28;
const _noon = 12;

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget(this.initialDateTime, {super.key});

  final DateTime initialDateTime;

  @override
  ObservingStatefulWidget<TimePickerWidget> createState() =>
      _TimePickerWidget();
}

class _TimePickerWidget extends ObservingStatefulWidget<TimePickerWidget> {
  final hourController = FixedExtentScrollController();
  final minuteController = FixedExtentScrollController();
  final secondController = FixedExtentScrollController();
  final meridianController = FixedExtentScrollController();
  Color? textColor;

  @override
  void initState() {
    super.initState();
    _jumpTo(widget.initialDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final themeExtension =
        Theme.of(context).extension<DateTimePickerThemeExtension>();
    final backgroundColor =
        themeExtension?.timeColor ??
        Theme.of(context).colorScheme.primaryContainer;
    textColor =
        themeExtension?.textColor ?? Theme.of(context).colorScheme.onSurface;
    return ColoredBox(
      color: backgroundColor,
      child: SizedBox(
        height: DateTimePicker.pickerSize.height,
        width: DateTimePicker.pickerSize.width,
        child: BlocBuilder<DateTimeCubit, DateTimeState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            // refresh when any time-related value changes
            if (state.refresh) _jumpTo(state.dateTime);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _hourPicker(state.dateTime),
                _colon(),
                _minutePicker(state.dateTime),
                _colon(),
                _secondPicker(state.dateTime),
                _meridianPicker(state.dateTime),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    meridianController.dispose();
    super.dispose();
  }

  void _jumpTo(DateTime dateTime) {
    final hour = dateTime.hour > _noon ? dateTime.hour - _noon : dateTime.hour;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hourController.jumpToItem(hour - 1);
      minuteController.jumpToItem(dateTime.minute);
      secondController.jumpToItem(dateTime.second);
      meridianController.jumpToItem(dateTime.hour >= _noon ? 1 : 0);
    });
  }

  Widget _hourPicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth - _compression,
    child: ListWheelScrollView.useDelegate(
      controller: hourController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        final hour24 = _convertTo24Hour(index + 1, state.hour >= _noon);
        context.read<DateTimeCubit>().changeHour(hour24);
      },
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List.generate(_noon, (index) {
          return Center(
            child: Text('${index + 1}', style: DateTimePicker.style)
                .fontWeight(
                  state.hour == _convertTo24Hour(index + 1, state.hour >= _noon)
                      ? FontWeight.bold
                      : FontWeight.normal,
                )
                .textColor(textColor!),
          );
        }),
      ),
    ),
  );

  Widget _minutePicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth - _compression,
    child: ListWheelScrollView.useDelegate(
      controller: minuteController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        context.read<DateTimeCubit>().changeMinute(index);
      },
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List.generate(60, (index) {
          return Center(
            child: Text(
                  index.toString().padLeft(2, '0'),
                  style: DateTimePicker.style,
                )
                .fontWeight(
                  state.minute == index ? FontWeight.bold : FontWeight.normal,
                )
                .textColor(textColor!),
          );
        }),
      ),
    ),
  );

  Widget _secondPicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth - _compression,
    child: ListWheelScrollView.useDelegate(
      controller: secondController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        context.read<DateTimeCubit>().changeSecond(index);
      },
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List.generate(60, (index) {
          return Center(
            child: Text(
                  index.toString().padLeft(2, '0'),
                  style: DateTimePicker.style,
                )
                .fontWeight(
                  state.second == index ? FontWeight.bold : FontWeight.normal,
                )
                .textColor(textColor!),
          );
        }),
      ),
    ),
  );

  Widget _meridianPicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth - _compression,
    child: ListWheelScrollView(
      controller: meridianController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        final isPm = index == 1;
        final hour = _convertTo24Hour(state.hour % _noon, isPm);
        context.read<DateTimeCubit>().changeHour(hour);
      },
      physics: const FixedExtentScrollPhysics(),
      children: [
        Center(
          child: const Text('AM', style: DateTimePicker.style)
              .fontWeight(
                state.hour < _noon ? FontWeight.bold : FontWeight.normal,
              )
              .textColor(textColor!),
        ),
        Center(
          child: const Text('PM', style: DateTimePicker.style)
              .fontWeight(
                state.hour >= _noon ? FontWeight.bold : FontWeight.normal,
              )
              .textColor(textColor!),
        ),
      ],
    ),
  );

  int _convertTo24Hour(int hour, bool isPm) {
    if (isPm && hour != _noon) return hour + _noon;
    if (!isPm && hour == _noon) return 0;
    return hour;
  }

  Widget _colon() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: const Text(
      ':',
      style: DateTimePicker.style,
    ).fontWeight(FontWeight.bold),
  );
}
