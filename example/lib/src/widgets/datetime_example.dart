import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icodeforyou_package/icodeforyou_package.dart';

class DateTimeExample extends StatefulWidget {
  const DateTimeExample({super.key});

  @override
  State<DateTimeExample> createState() => _DateTimeExample();
}

class _DateTimeExample extends State<DateTimeExample> {
  String content = 'No Picker Content';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Gap(40),
          ModalDialog<DateTime>(
            triggerWidget: const Text(
              'PRESS ME',
              style: TextStyle(fontSize: 24),
            ).withPaddingAll(8).withBorder(Colors.green),
            child: (returnValue) {
              return DateTimePicker(
                hapticFeedback: true,
                dateTime: DateTime.now(),
                onSelectedDateTime: returnValue,
              );
            },
            onReturnValue: (result) {
              setState(
                () => content = (result != null) ? 'UTC: $result' : 'Canceled!',
              );
            },
          ),
          const Gap(20),
          Text(content).fontSize(22),
        ],
      ),
    );
  }
}
