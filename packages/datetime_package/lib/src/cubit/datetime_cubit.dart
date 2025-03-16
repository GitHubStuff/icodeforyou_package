// Improve readability
// ignore_for_file: omit_local_variable_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'datetime_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTimeCubit({DateTime? starting})
    : super(
        DateTimeState(
          dateTime: starting ?? DateTime.now(),
          refresh: false,
          pickerType: PickerType.date,
        ),
      );

  void changeYear(int year) {
    DateTime newDateTime = state.dateTime.copyWith(year: year);
    bool refresh = false;
    if (newDateTime.month != state.dateTime.month) {
      final lastDay = _daysInMonth(state.dateTime.month, state.dateTime.year);
      newDateTime = state.dateTime.copyWith(
        month: state.dateTime.month,
        day: lastDay,
      );
      refresh = true;
    }
    emit(
      DateTimeState(
        dateTime: newDateTime,
        refresh: refresh,
        pickerType: state.pickerType,
      ),
    );
  }

  void changeMonth(int month) {
    DateTime newDateTime = state.dateTime.copyWith(month: month);
    bool refresh = false;
    if (newDateTime.month != month) {
      final lastDay = _daysInMonth(month, state.dateTime.year);
      newDateTime = state.dateTime.copyWith(month: month, day: lastDay);
      refresh = true;
    }
    emit(
      DateTimeState(
        dateTime: newDateTime,
        refresh: refresh,
        pickerType: state.pickerType,
      ),
    );
  }

  void changeDay(int day) {
    final newState = DateTimeState(
      dateTime: state.dateTime.copyWith(day: day),
      refresh: false,
      pickerType: state.pickerType,
    );
    emit(newState);
  }

  void changeHour(int hour) {
    final newState = DateTimeState(
      dateTime: state.dateTime.copyWith(hour: hour),
      refresh: false,
      pickerType: state.pickerType,
    );
    emit(newState);
  }

  void changeMinute(int minute) {
    final newState = DateTimeState(
      dateTime: state.dateTime.copyWith(minute: minute),
      refresh: false,
      pickerType: state.pickerType,
    );
    emit(newState);
  }

  void changeSecond(int second) {
    final newState = DateTimeState(
      dateTime: state.dateTime.copyWith(second: second),
      refresh: false,
      pickerType: state.pickerType,
    );
    emit(newState);
  }

  void changeMeridian(int index) {
    final newState = DateTimeState(
      dateTime: state.dateTime.copyWith(
        hour: state.dateTime.hour + (index * 12),
      ),
      refresh: false,
      pickerType: state.pickerType,
    );
    emit(newState);
  }

  void changePickerType(PickerType pickerType) {
    emit(
      DateTimeState(
        dateTime: state.dateTime,
        refresh: false,
        pickerType: pickerType,
      ),
    );
  }

  int _daysInMonth(int month, int year) =>
      [
        31,
        if (_isLeap(year)) 29 else 28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31,
      ][month - 1];

  bool _isLeap(int year) =>
      (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);
}
