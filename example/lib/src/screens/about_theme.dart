part of 'example_homescreen.dart';

Widget _aboutTheme() {
  return const AboutCard(
    title: Text('About Theme'),
    description: Text('© Ready available theme widgets/components'),
    demoWidgets: [
      AboutContent(
        title: Text('Theme Preference Card'),
        demo: ThemeSettingWidget(),
        size: Size(300, 200),
      ),
    ],
  );
}
