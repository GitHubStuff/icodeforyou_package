import 'package:datetime_package/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';
import 'package:intl/intl.dart';

const _baseYear = 1900;

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget(this.initialDateTime, {super.key});

  final DateTime initialDateTime;

  @override
  ObservingStatefulWidget<DatePickerWidget> createState() =>
      _DatePickerWidget();
}

class _DatePickerWidget extends ObservingStatefulWidget<DatePickerWidget> {
  final monthController = FixedExtentScrollController();
  final dayController = FixedExtentScrollController();
  final yearController = FixedExtentScrollController();
  final List<String> _months = [];
  Color? textColor;

  @override
  void initState() {
    super.initState();
    for (var i = 1; i <= 12; i++) {
      _months.add(DateFormat.MMM().format(DateTime(2021, i)));
    }
    // Jump to the correct position after the first frame is rendered
    _jumpTo(widget.initialDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final themeExtension =
        Theme.of(context).extension<DateTimePickerThemeExtension>();
    final backgroundColor =
        themeExtension?.dateColor ??
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
            // refresh when the number of days in the month changes
            if (state.refresh) _jumpTo(state.dateTime);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _monthPicker(state.dateTime),
                _dayPicker(state.dateTime),
                _yearPicker(state.dateTime),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    monthController.dispose();
    dayController.dispose();
    yearController.dispose();
    super.dispose();
  }

  void _jumpTo(DateTime dateTime) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      monthController.jumpToItem(dateTime.month - 1);
      dayController.jumpToItem(dateTime.day - 1);
      yearController.jumpToItem(dateTime.year - _baseYear);
    });
  }

  Widget _monthPicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth, // Adjusted to give uniform width
    child: ListWheelScrollView.useDelegate(
      controller: monthController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        context.read<DateTimeCubit>().changeMonth(
          index + 1,
        ); // Months are 1-indexed
      },
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildLoopingListDelegate(
        children:
            _months.asMap().entries.map((entry) {
              return Center(
                child: Text(entry.value, style: DateTimePicker.style)
                    .fontWeight(
                      state.month == entry.key + 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                    )
                    .textColor(textColor!),
              );
            }).toList(),
      ),
    ),
  );

  Widget _dayPicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth, // Same width as month picker
    child: ListWheelScrollView.useDelegate(
      controller: dayController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        context.read<DateTimeCubit>().changeDay(index + 1);
      },
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List.generate(
          DateTimeExt.daysIn(month: state.month, year: state.year),
          (index) {
            return Center(
              child: Text('${index + 1}', style: DateTimePicker.style)
                  .fontWeight(
                    state.day == index + 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  )
                  .textColor(textColor!),
            );
          },
        ),
      ),
    ),
  );

  Widget _yearPicker(DateTime state) => SizedBox(
    width: DateTimePicker.itemWidth, // Same width as month picker
    child: ListWheelScrollView.useDelegate(
      controller: yearController,
      itemExtent: DateTimePicker.itemExtent,
      onSelectedItemChanged: (index) {
        context.read<DateTimeCubit>().changeYear(_baseYear + index);
      },
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List.generate(500, (index) {
          return Center(
            // Improve readability
            // ignore: require_trailing_commas
            child: Text('${_baseYear + index}', style: DateTimePicker.style)
                .fontWeight(
                  state.year == _baseYear + index
                      ? FontWeight.bold
                      : FontWeight.normal,
                )
                .textColor(textColor!),
          );
        }),
      ),
    ),
  );
}
