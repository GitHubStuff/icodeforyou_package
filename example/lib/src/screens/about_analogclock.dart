part of 'example_homescreen.dart';

Widget _aboutAnalogClock() {
  return const AboutCard(
    title: Text('Analog Clock'),
    description: Text('© Animated Analog Clock'),
    demoWidgets: [
      AboutContent(
        title: Text('48px Analog Clock'),
        demo: Center(child: AnalogClock(radius: 48)),
        size: Size(50, 50),
      ),
      AboutContent(
        title: Text('75px Analog Clock'),
        demo: Center(child: AnalogClock(radius: 75)),
        size: Size(100, 100),
      ),
    ],
  );
}
