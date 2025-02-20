part of 'example_homescreen.dart';

Widget _aboutAquaButton() {
  return const AboutCard(
    title: Text('Aqua Button'),
    description: Text('© Old style MacOS button'),
    demoWidgets: [
      AboutContent(
        title: Text('Aqua Button'),
        demo: Center(
          child: AquaButton(materialColor: Colors.amber, radius: 48),
        ),
        size: Size(300, 200),
      ),
    ],
  );
}
