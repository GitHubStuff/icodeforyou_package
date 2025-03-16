part of 'example_homescreen.dart';

Widget _aboutDateTime() {
  return AboutCard(
    title: const Text('DateTime'),
    description: const Text('© DateTime Enhancements'),
    demoWidgets: [
      const AboutContent(
        title: Text('DateTime Picker'),
        demo: DateTimeExample(),
        size: Size(300, 300),
      ),
      AboutContent(
        title: const Text('DateTimeDifference'),
        demo: Center(
          child: Column(
            children: [
              const Gap(6),
              const Text('Original:').fontSize(28),
              Text(
                DateTimeDifferenceOriginal(
                  startEvent: DateTime(1960, 12, 1, 15, 56),
                  endEvent: DateTime.now(),
                ).toString(),
              ).fontSize(26),
              const Gap(6),
              const Text('Enhanced:').fontSize(28),
              Text(
                DateTimeDifference(
                  startEvent: DateTime(1960, 12, 1, 15, 56),
                  endEvent: DateTime.now(),
                ).toString(),
              ).fontSize(26),
            ],
          ),
        ),
        size: const Size(300, 200),
      ),
    ],
  );
}
