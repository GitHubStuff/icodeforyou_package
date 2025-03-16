part of 'datetime_cubit.dart';

enum PickerType { date, time }

class DateTimeState extends Equatable {
  const DateTimeState({
    required this.dateTime,
    required this.refresh,
    required this.pickerType,
  });

  final DateTime dateTime;
  final bool refresh;
  final PickerType pickerType;

  @override
  List<Object> get props => [dateTime, refresh, pickerType];

  DateTimeState copyWith({
    DateTime? dateTime,
    bool? refresh,
    PickerType? pickerType,
  }) {
    return DateTimeState(
      dateTime: dateTime ?? this.dateTime,
      refresh: refresh ?? this.refresh,
      pickerType: pickerType ?? this.pickerType,
    );
  }
}
