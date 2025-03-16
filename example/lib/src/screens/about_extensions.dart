part of 'example_homescreen.dart';

Widget _aboutExtensions() {
  return AboutCard(
    title: const Text('Extensions'),
    description: const Text('© Collection of Widgets and Utilities'),
    demoWidgets: [
      AboutContent(
        title: const Text('DateTime Extensions'),
        demo: Center(
          child: Text(DateTime.now().toUtc().toIso8601String())
              .fontSize(22)
              .textColor(Colors.yellow[100]!)
              .withBackground(Colors.purple[900]!),
        ),
        size: const Size(300, 48),
      ),
      AboutContent(
        title: const Text('Image Extensions'),
        demo: Center(
          child: Image.asset(
            'assets/images/ic4u1024x1024.png',
          ).rotate(percentage: 0.125),
        ),
        size: const Size(300, 48),
      ),
      AboutContent(
        title: const Text('Add background to widget'),
        demo: Center(
          child: const Text(
            'Background',
            style: TextStyle(fontSize: 24),
          ).withBackground(Colors.green),
        ),
        size: const Size(300, 48),
      ),
      AboutContent(
        title: const Text('Add border to widget'),
        demo: Center(
          child: const Text(
            'Background',
            style: TextStyle(fontSize: 24),
          ).withBorder(Colors.red),
        ),
        size: const Size(300, 48),
      ),
      AboutContent(
        title: const Text('Opacity'),
        demo: Center(
          child: const Text(
            'Something Opaque',
            style: TextStyle(fontSize: 24),
          ).withOpacity(0.5),
        ),
        size: const Size(300, 48),
      ),
      AboutContent(
        title: const Text('With Wrap'),
        demo: Center(
          child: const Text(
            'Something to Wrap',
            style: TextStyle(fontSize: 24),
          ).withWrap(left: 2, right: 30, top: 4, bottom: 5, color: Colors.blue),
        ),
        size: const Size(300, 48),
      ),
    ],
  );
}
